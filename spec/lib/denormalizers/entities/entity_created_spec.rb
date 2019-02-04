require 'rails_helper'

describe Denormalizers::Entities::EntityCreated do
  let(:event_store) { Rails.configuration.event_store }
  let(:uid) { Services::UniqueIdGenerator.new.call }
  let(:entity_data) { {
      uid: uid,
      name: "random_entity",
      description: "this is a random description",
      state: "In use",
      extra_data: { d1: "something", d2: "else" }
  } }

  context "when an entity created event occurs" do
    it "creates a corresponding read model" do
      expect {
        event_store.publish(
          Events::EntityCreated.new(data: entity_data))
      }.to change { Entity.count }.by 1

      entity = Entity.find_by_uid(entity_data[:uid])
      expect(entity).to have_attributes(entity_data)
    end
  end
end
