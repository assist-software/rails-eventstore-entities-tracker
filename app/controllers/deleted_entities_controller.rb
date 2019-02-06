class DeletedEntitiesController < ApplicationController
  before_action :set_deleted_entity, only: [:show, :restore]

  include Commands::Execute
  include DeletedEntitiesHelper

  def index
    @deleted_entities = read_stream("DeletedEntities").backward.to_a.uniq { |en| en.data[:uid]}
  end

  def show
  end

  def restore
    cmd = Commands::Entities::RestoreEntity.new(uid: @deleted_entity.last.data[:uid])
    execute(cmd)

    redirect_to "/entities"
  end

  private

  def set_deleted_entity
    @deleted_entity = read_stream("Domain::Entity$#{params[:id]}")
  end
end
