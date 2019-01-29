FactoryBot.define do
  factory :entity do
    sequence(:uid) { |n| "entity_uid#{n}" }
    sequence(:name) { |n| "name#{n}" }
    description { "some random description" }
    state { 1 }
  end
end