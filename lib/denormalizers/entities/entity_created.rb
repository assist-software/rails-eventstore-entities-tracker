module Denormalizers
  module Entities
    class EntityCreated
      def call(event)
        ::Entity.create!(event.data)
      end
    end
  end
end