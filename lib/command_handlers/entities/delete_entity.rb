module CommandHandlers
  module Entities
    class DeleteEntity
      def call(command)
        stream = "Domain::Entity$#{command.aggregate_uid}"

        aggregate = Domain::Entity.new(command.aggregate_uid).load(stream)
        aggregate.delete(command.aggregate_uid)
        aggregate.store
      end
    end
  end
end