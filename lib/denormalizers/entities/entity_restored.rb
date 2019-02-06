module Denormalizers
  module Entities
    class EntityRestored
      def call(event)
        uid = event.data[:uid]
        agg = Domain::Entity.new(uid).load("Domain::Entity$#{uid}")
        ::Entity.create!(uid: uid, name: agg.name, description: agg.description, state: agg.state, extra_data: agg.extra_data)
      end
    end
  end
end