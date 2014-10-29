FactoryGirl.define do
  factory :round do
    game
    association :player, {
      factory: :user,
      username: 'a',
      email: 'a@b.c',
      password: 'abacab'
    }
  end
end
