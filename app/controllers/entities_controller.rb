class EntitiesController < ApplicationController
  before_action :set_entity, only: [:show, :edit, :update, :destroy]


  include Commands::Execute

  # GET /entities
  # GET /entities.json
  def index
    @entities = Entity.all
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
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

    redirect_to "/entities"
  end

  # PATCH/PUT /entities/1
  # PATCH/PUT /entities/1.json
  def update
    entity_data = entity_params
    entity_data[:uid] = @entity.uid
    cmd = Commands::Entities::EditEntity.new(entity_data)
    execute(cmd)

    redirect_to "/entities"
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    cmd = Commands::Entities::DeleteEntity.new(@entity.uid)
    execute(cmd)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entity
    @entity = Entity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entity_params
    params.require(:entity).permit(:uid, :name, :description, :state, :extra_data)
  end
end
