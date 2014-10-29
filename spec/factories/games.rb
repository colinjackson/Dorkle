FactoryGirl.define do
  factory :game do
    sequence(:title) { |n| "Game Numero #{n}" }
    source "http://www.ruby-doc.org/core-2.1.4/Array.html"
    time_limit 120
    author
  end
end
