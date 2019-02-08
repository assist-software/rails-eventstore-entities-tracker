class EntitiesController < ApplicationController
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  include Commands::Execute
  include DeletedEntitiesHelper

  # GET /entities
  # GET /entities.json
  def index
    @entities = Entity.all.page(params[:page])
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
    start = params[:last_event_id] || :head
    actions = read_stream("Domain::Entity$#{@entity.uid}", start: start, count: 2)
    @paginatable_array = Kaminari.paginate_array(actions, total_count: 10).page(params[:page])
  end

  # GET /entities/new
  def new
    @entity = Entity.new
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities
  # POST /entities.json
  def create
    entity_data = entity_params
    entity_data[:uid] = Services::UniqueIdGenerator.new.call
    cmd = Commands::Entities::CreateEntity.new(entity_data)
    execute(cmd)
    redirect_to entities_url, success: 'Entity was successfully created.'
  rescue => error
    redirect_to new_entity_url, warning: error_messages(error)
  end

  # PATCH/PUT /entities/1
  # PATCH/PUT /entities/1.json
  def update
    entity_data = entity_params
    entity_data[:uid] = @entity.uid
    cmd = Commands::Entities::EditEntity.new(entity_data)
    execute(cmd)
    redirect_to entities_url, success: 'Entity was successfully updated.'
  rescue => error
    redirect_to edit_entity_url, warning: error_messages(error)
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    cmd = Commands::Entities::DeleteEntity.new(uid: @entity.uid)
    execute(cmd)
    redirect_to entities_url, success: 'Entity was successfully deleted.'
  rescue => error
    redirect_to entities_url, warning: error_messages(error)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entity
    @entity = Entity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entity_params
    params.require(:entity).permit(:name, :description, :state, :extra_data)
  end

  def error_messages(error)
    error&.message&.full_messages&.join("\n")
  end
end
