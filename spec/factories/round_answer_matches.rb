FactoryGirl.define do
  factory :round_answer_match do
    association :answer, factory: :game_answer
    round
  end
end
