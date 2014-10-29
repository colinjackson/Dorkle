FactoryGirl.define do
  factory :game_answer do
    sequence(:answer) { |n| "#{n}" }
    game
  end
end
