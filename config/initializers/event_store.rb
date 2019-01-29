Rails.application.config.event_store.tap do |es|
  es.subscribe(Denormalizers::Entities::EntityCreated, to: [Events::EntityCreated])
  es.subscribe(Denormalizers::Entities::EntityEdited, to: [Events::EntityEdited])
end