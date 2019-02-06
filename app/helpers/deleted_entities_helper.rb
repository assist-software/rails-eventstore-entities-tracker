module DeletedEntitiesHelper
  def read_stream(stream_name)
    Rails.configuration.event_store.read.stream(stream_name)
  end

  def load_entity_aggregate(uid)
    Domain::Entity.new(uid).load("Domain::Entity$#{uid}")
  end
end
