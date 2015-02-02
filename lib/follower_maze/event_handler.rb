module FollowerMaze
  class EventHandler
    def initialize
      @events = []
      @sender = nil
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
      @sender = Thread.new do
        loop do
          event = @buffer.pop
          event.execute!
        end
      end

      @consumer = Thread.new do
        loop do
          @mutex.synchronize do
            @buffer << @events_buffer.get_next if @events_buffer.has_next
          end
        end
      end
    end

    def stop
      @sender.kill
      @consumer.kill
    end
  end
end
