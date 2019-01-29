require 'rails_helper'

describe Commands::Entities::EditEntity do
  include Commands::Execute

  context "when running edit command" do
    let(:uid_generator) { Services::UniqueIdGenerator.new }
    let(:event_store) { Rails.configuration.event_store }
    let(:entity_uid) { uid_generator.call }
    let(:command) { Commands::Entities::EditEntity.new(update_data) }

    let(:data) { {
        uid: entity_uid,
        name: "random_entity",
        description: "this is a random description",
        state: 1,
        extra_data: { d1: "something", d2: "new" }
    } }

    before do
      cmd = Commands::Entities::CreateEntity.new(data)
      execute(cmd)
    end

    context "and the command includes all needed data" do
      let(:update_data) { {
          uid: entity_uid,
          name: "updated_random_entity",
          description: "updated description",
          state: 2,
          extra_data: { d1: "something", d2: "else" }
      } }

      it "applies the updated data to the entity" do
        execute(command)

        expect(event_store).to have_published(an_event(Events::EntityEdited)
          .with_data(uid: entity_uid, name: "updated_random_entity", description: "updated description", state: 2, extra_data: { d1: "something", d2: "else" }))
      end
    end

    context "and uid is missing" do
      let(:update_data) { {
          name: "sample"
      } }

      it "raises a validation exception" do
        expect { execute(command) }.to raise_error(Commands::ValidationError)
      end
    end
  end
end
