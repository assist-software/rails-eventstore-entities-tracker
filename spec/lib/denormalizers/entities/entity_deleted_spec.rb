require 'rails_helper'

describe Denormalizers::Entities::EntityDeleted do
  include Commands::Execute

  context "when entity delete denormalizer is applied" do
    let(:event_store) { Rails.configuration.event_store }
    let!(:entity) { create(:entity) }

    it "deletes the entity" do
      expect{
        event_store.publish(Events::EntityDeleted.new(data: { uid: entity.uid }))
      }.to change{ Entity.count }.by -1
    end
  end
end