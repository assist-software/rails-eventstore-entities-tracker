module DeletedEntitiesHelper
  def read_stream(stream_name, start: :head, count: 100)
    # byebug
    Rails.configuration.event_store
      .read
      .backward
      .stream(stream_name)
      .from(start)
      .limit(count)
      .to_a
  end

  def load_entity_aggregate(uid)
    Domain::Entity.new(uid).load("Domain::Entity$#{uid}")
  end
end
