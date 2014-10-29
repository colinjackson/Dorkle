FactoryGirl.define do
  factory :game do
    title "Name the Ruby Array methods!"
    subtitle "How many Ruby Array methods can YOU name in 2 minutes?"
    source "http://www.ruby-doc.org/core-2.1.4/Array.html"
    time_limit 120
    association :author, factory: :user
  end
end
