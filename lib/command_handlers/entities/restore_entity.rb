module CommandHandlers
  module Entities
    class RestoreEntity
      def call(command)
        stream = "Domain::Entity$#{command.aggregate_uid}"

        aggregate = Domain::Entity.new(command.aggregate_uid).load(stream)
        aggregate.restore(command.aggregate_uid)
        aggregate.store
      end
    end
  end
end