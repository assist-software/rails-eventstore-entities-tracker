class DeletedEntitiesController < ApplicationController
  before_action :set_deleted_entity, only: [:show]

  def index
    @deleted_entities = read_stream("DeletedEntities").to_a
  end

  def show
  end

  private

  def set_deleted_entity
    @deleted_entity = read_stream("Domain::Entity$#{params[:id]}")
  end

  def read_stream(stream_name)
    Rails.configuration.event_store.read.stream(stream_name)
  end
end
