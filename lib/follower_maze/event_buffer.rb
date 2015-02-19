module FollowerMaze
  class EventBuffer
    def initialize
      @events = {}
      @next_event = 1
    end

    def add_event(event)
      @events[event.id] = event
    end

    def has_next?
      !@events[@next_event].nil?
    end

    def get_next
      @events.delete(@next_event).tap { @next_event +=1 }
    end
  end
end