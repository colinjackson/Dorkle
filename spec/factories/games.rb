# == Schema Information
#
# Table name: games
#
#  id                     :integer          not null, primary key
#  title                  :string(255)      not null
#  subtitle               :string(255)
#  source                 :string(255)      not null
#  time_limit             :integer          not null
#  author_id              :integer          not null
#  created_at             :datetime
#  updated_at             :datetime
#  image_file_name        :string(255)
#  image_content_type     :string(255)
#  image_file_size        :integer
#  image_updated_at       :datetime
#  rounds_count           :integer
#  completed_rounds_count :integer
#  answer_matches_count   :integer
#

FactoryGirl.define do
  factory :game do
    sequence(:title) { |n| "Game Numero #{n}" }
    source "http://www.ruby-doc.org/core-2.1.4/Array.html"
    time_limit 120
    author
  end
end
