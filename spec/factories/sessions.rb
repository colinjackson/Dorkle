FactoryGirl.define do
  factory :session do
    user
    session_token { SecureRandom.base64(16) }
  end
end
