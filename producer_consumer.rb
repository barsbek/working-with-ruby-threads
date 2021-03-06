require "thread"

queue = Queue.new

producer = Thread.new do
  10.times do
    queue.push(Time.now.to_i)
    sleep 1
  end
end

consumers = []

3.times do
  consumers << Thread.new do
    loop do
      unix_timestamp = queue.pop()
      formatted_timestamp = unix_timestamp.to_s.reverse.gsub(/(\d\d\d)/, '\1,').reverse
      puts "It's been #{formatted_timestamp} seconds since the epoch!"
    end
  end
end

producer.join
