# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :session do
    user
    session_token { SecureRandom.base64(16) }
  end
end
