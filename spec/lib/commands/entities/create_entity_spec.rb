require 'rails_helper'

describe Commands::Entities::CreateEntity do
  include Commands::Execute

  let(:event_store) { Rails.configuration.event_store }
  let(:uid) { Services::UniqueIdGenerator.new.call }
  let(:command) { described_class.new(entity_data) }

  context "when the required fields are provided" do
    let(:entity_data) { {
        uid: uid,
        name: "random_entity",
        description: "this is a random description",
        state: 1,
        extra_data: { d1: "something", d2: "else" }
    } }

    it "creates the entity" do
      execute(command)

      expect(event_store).to have_published(an_event(Events::EntityCreated)
        .with_data(entity_data))
    end
  end

  context "when passed data is incorrect - name is missing" do
    let(:entity_data) { {
        uid: uid
    } }

    it "returns an error" do
      expect{ execute(command) }.to raise_error(Commands::ValidationError)
    end
  end
end
