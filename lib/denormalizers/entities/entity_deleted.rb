module Denormalizers
  module Entities
    class EntityDeleted
      def call(event)
        entity = Entity.find_by_uid(event.data[:uid])
        entity.destroy if entity
      end
    end
  end
end