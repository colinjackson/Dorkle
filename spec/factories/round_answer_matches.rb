# == Schema Information
#
# Table name: round_answer_matches
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :round_answer_match do
    association :answer, factory: :game_answer
    round
  end
end
