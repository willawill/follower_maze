module FollowerMaze
  class EventBuffer
    attr_reader :events

    def initialize
      @events = {}
      @next_event = 1
    end

    def add_event(event)
      @events[event.id] = event
    end

    def has_next
      !!@events[@next_event.to_s]
    end

    def get_next
      @events[@next_event.to_s].tap do |_|
        @next_event += 1
      end
    end
  end
end