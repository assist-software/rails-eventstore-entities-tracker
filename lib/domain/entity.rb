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

    def edit(data)
      apply Events::EntityEdited.new(data: data)
    end

    def delete(uid)
      apply Events::EntityDeleted.new(data: { uid: uid })
    end

    private

    def apply_entity_created(event)
      @name = event.data[:name]
      @description = event.data[:description]
      @state = event.data[:state]
      @extra_data = event.data[:extra_data]
    end

    def apply_entity_edited(event)
      @name = event.data[:name]
      @description = event.data[:description]
      @state = event.data[:state]
      @extra_data = event.data[:extra_data]
    end

    def apply_entity_deleted(event)
      @deleted = true
    end
  end
end
