# == Schema Information
#
# Table name: users
#
#  id                                   :integer          not null, primary key
#  username                             :string(255)      not null
#  email                                :string(255)      not null
#  name                                 :string(255)
#  password_digest                      :string(255)      not null
#  created_at                           :datetime
#  updated_at                           :datetime
#  image_file_name                      :string(255)
#  image_content_type                   :string(255)
#  image_file_size                      :integer
#  image_updated_at                     :datetime
#  rounds_count                         :integer          default(0)
#  completed_rounds_count               :integer          default(0)
#  completed_answer_matches_count       :integer          default(0)
#  created_games_count                  :integer          default(0)
#  created_games_completed_rounds_count :integer          default(0)
#

FactoryGirl.define do
  factory :user, aliases: [:author, :player] do
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "secret"
  end
end
