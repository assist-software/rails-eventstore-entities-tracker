module Denormalizers
  module Entities
    class EntityEdited
      def call(event)
        entity = Entity.find_by_uid(event.data[:uid])

        entity.update(event.data) if entity
      end
    end
  end
end