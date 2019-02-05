module CommandHandlers
  module Entities
    class EditEntity
      def call(command)
        stream = "Domain::Entity$#{command.aggregate_uid}"

        entity_data = {
          uid: command.uid,
          name: command.name,
          description: command.description,
          state: command.state,
          extra_data: command.extra_data
        }.reject{ |_, v| v.nil? }

        aggregate = Domain::Entity.new(command.aggregate_uid).load(stream)
        aggregate.edit(entity_data)
        aggregate.store
      end
    end
  end
end
