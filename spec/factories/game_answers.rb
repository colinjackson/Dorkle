# == Schema Information
#
# Table name: game_answers
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  answer     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  regex      :string(255)
#

FactoryGirl.define do
  factory :game_answer do
    sequence(:answer) { |n| "#{n}" }
    game
  end
end
