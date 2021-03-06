# == Schema Information
#
# Table name: rounds
#
#  id           :integer          not null, primary key
#  game_id      :integer          not null
#  player_id    :integer
#  is_completed :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  start_time   :datetime
#

FactoryGirl.define do
  factory :round do
    game
  end
end
