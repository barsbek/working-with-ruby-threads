require "benchmark"
require "bigdecimal"
require "bigdecimal/math"

DIGITS = 10_000
ITERATIONS = 24

def calculate_pi(thread_count)
	threads = []

	thread_count.times do
		threads << Thread.new do
			iterations_per_thread = ITERATIONS/thread_count

			iterations_per_thread.times do
				BigMath.PI(DIGITS)
			end
		end
	end
	threads.each(&:join)
end

Benchmark.bm(20) do |bm|
  [1,2,3,4,6,8,12,24].each do |thread_count|
  	bm.report("with #{thread_count} threads") do
  		calculate_pi(thread_count)
  	end
  end
end