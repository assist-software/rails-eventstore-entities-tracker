module CommandHandlers
  module Entities
    class CreateEntity
      def call(command)
        stream = "Domain::Entity$#{command.aggregate_uid}"
        entity_data = {
            uid: command.uid,
            name: command.name,
            description: command.description,
            state: command.state,
            extra_data: command.extra_data
        }

        aggregate = Domain::Entity.new(command.aggregate_uid).load(stream)
        aggregate.create(entity_data)
        aggregate.store
      end
    end
  end
end