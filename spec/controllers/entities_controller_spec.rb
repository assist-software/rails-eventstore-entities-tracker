require 'rails_helper'

describe EntitiesController, type: :controller do
  context 'GET #index' do
    let!(:entities) { create_list(:entity, 3) }

    subject(:all_entities) { get :index }

    it 'has a 200 status code' do
      all_entities
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      all_entities
      expect(response).to render_template('index')
    end

    it 'assigns @entities' do
      all_entities
      expect(assigns(:entities)).to eq(entities)
    end
  end

  context 'GET #show' do
    let!(:entity) { create(:entity) }
    subject(:fetch_entity) { get :show, params: { id: entity.id } }

    fit 'has a 200 status code' do
      fetch_entity
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      fetch_entity
      expect(response).to render_template('show')
    end

    it 'assigns the requested entity to @entity' do
      fetch_entity
      expect(assigns(:entity)).to eq(entity)
    end
  end

  context 'POST #create' do
    let(:params) { {} }
    let(:create_entity) { post :create, params: { entity: params } }

    context 'with valid attributes' do
      let(:params) do
        {
          name: 'Random entity',
          description: 'a random description',
          state: 'New',
          extra_data: {}
        }
      end

      it 'saves the new entity in the database' do
        expect{ create_entity }.to change{ Entity.count }.by 1
      end

      it 'redirects to the entities page' do
        create_entity
        expect(response).to redirect_to entities_path
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        {
          description: 'a random description',
        }
      end
      it 'does not save the new entity in the database' do
        expect{ create_entity }.to_not change{ Entity.count }
      end

      it 'redirects to new entity page' do
        create_entity
        expect(response).to redirect_to new_entity_url
      end
    end
  end

  context 'PUT #update' do
    let!(:entity) { create(:entity) }
    let(:update_entity) { put :update, params: { id: entity, entity: params } }

    let(:params) do
      {
        name: 'A new name',
        state: 'Broken',
        extra_data: "{ key1: 123 }"
      }
    end

    it "changes entity's attributes" do
      expect{ update_entity; entity.reload }
        .to change { entity.name }.to(params[:name])
        .and change { entity.state }.to(params[:state])
        .and change { entity.extra_data }.to params[:extra_data]
    end

    it 'redirects to the entities page' do
      update_entity
      expect(response).to redirect_to entities_path
    end
  end

  context 'DELETE #destroy' do
    let!(:entity) { create(:entity) }
    let(:delete_entity) { delete :destroy, params: { id: entity.id } }

    it 'deletes the entity' do
      expect{ delete_entity }.to change{ Entity.count }.by -1
    end

    it 'redirects to entities#index' do
      delete_entity
      response.should redirect_to entities_url
    end
  end
end
