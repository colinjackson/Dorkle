require 'rails_helper'
require 'necessary_and_unique_attribute'

RSpec.describe Game, :type => :model do

  describe "validates" do
    describe "title" do
      it_behaves_like 'a necessary and unique attribute', :game, :title
    end

    describe "presences" do
      [:source, :time_limit, :author].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    describe "source" do
      it do
        should allow_value("www.ruby-doc.org/core-2.1.4/Array.html").for(:source)
        should_not allow_value("my own brain lol").for(:source)
      end
    end

    describe "time_limit" do
      it do
        should validate_numericality_of(:time_limit).only_integer
      end
      it do
        should validate_numericality_of(:time_limit)
          .is_greater_than_or_equal_to(60)
      end
      it do
        should validate_numericality_of(:time_limit)
          .is_less_than_or_equal_to(900)
      end
    end
  end

  describe "associates with" do
    describe "user" do
      it { should belong_to(:author) }
    end

    describe "game answer" do
      it { should have_many(:answers) }
    end
  end

end
