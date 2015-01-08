module FollowerMaze
  class Event
    attr_reader :id, :event_type, :from, :to

    def initialize(pay_load)
      @id, @event_type, @from, @to = pay_load.split("|")
    end

    def execute!
      p "Doing some stuff"
    end
  end
end
