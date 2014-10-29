FactoryGirl.define do
  factory :user, aliases: [:author, :player] do
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "secret"
  end
end
