module Domain
  class Entity
    include AggregateRoot

    attr_reader :uid, :name, :description, :state, :extra_data

    def initialize(uid)
      @uid = uid
    end

    def create(data)
      apply Events::EntityCreated.new(data: data)
    end

    private

    def apply_entity_created(event)
      @name = event.data[:name]
      @description = event.data[:description]
      @state = event.data[:state]
      @extra_data = event.data[:extra_data]
    end
  end
end
