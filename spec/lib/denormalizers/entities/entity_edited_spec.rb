require 'rails_helper'

describe Denormalizers::Entities::EntityEdited do
  let(:event_store) { Rails.configuration.event_store }
  let(:uid) { Services::UniqueIdGenerator.new.call }
  let(:updated_name) { "updated name" }
  let(:entity) { create(:entity, uid: uid, name: "test name") }

  context "when an entity edited event occurs" do
    context "and there is a corresponding read model for that entity" do
      it "updates the data on the read model" do
        expect {
          event_store.publish(
            Events::EntityEdited.new(data: { uid: uid, name: updated_name }))
        }.to change { entity.reload.name }.to updated_name
      end
    end
  end
end
