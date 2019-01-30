require 'rails_helper'

describe Commands::Entities::DeleteEntity do
  include Commands::Execute

  context "when running entity delete command" do
    let(:entity) { create(:entity) }
    let(:event_store) { Rails.configuration.event_store }
    let(:uid) { Services::UniqueIdGenerator.new.call }

    context "when entity_uid is passed" do
      let(:command) { Commands::Entities::DeleteEntity.new({ uid: uid }) }

      it "deletes the entity" do
        execute(command)

        expect(event_store).to have_published(an_event(Events::EntityDeleted).with_data({ uid: uid }))
      end
    end

    context "when entity_uid is missing" do
      let(:command) { Commands::Entities::DeleteEntity.new }

      it "returns an error" do
        expect{ execute(command) }.to raise_error(Commands::ValidationError)
      end
    end
  end
end
