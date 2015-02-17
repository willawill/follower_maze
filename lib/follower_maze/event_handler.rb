module FollowerMaze
  class EventHandler
    def initialize
      @events = []
      @producer = nil
      @consumer = nil
      @events_buffer = EventBuffer.new
      @mutex = Mutex.new
      @buffer = Queue.new
    end

    def add_event(event)
      @mutex.synchronize do
        @events_buffer.add_event(event)
      end
    end

    def start
      @producer = Thread.new do
        loop do
          @mutex.synchronize do
            @buffer << @events_buffer.get_next if @events_buffer.has_next
            @buffer.length if @buffer.length > 0
          end
        end
      end

      @consumer = Thread.new do
        loop do
          event = @buffer.pop
          event.execute!
        end
      end
    end

    def stop
      @producer.kill
      @consumer.kill
    end
  end
end
