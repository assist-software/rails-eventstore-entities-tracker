module Events
  EntityCreated = Class.new(RailsEventStore::Event)
  EntityEdited = Class.new(RailsEventStore::Event)
  EntityDeleted = Class.new(RailsEventStore::Event)
  EntityRestored = Class.new(RailsEventStore::Event)
end