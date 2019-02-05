class DeletedEntitiesTracker
  def call(event)
    Rails.application.config.event_store.link(
      event.event_id,
      stream_name: "DeletedEntities"
    )
  end
end
