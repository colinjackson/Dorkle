require 'rails_helper'

RSpec.describe Round, :type => :model do

  describe "validates" do
    let(:round) { create(:round) }

    it { should validate_presence_of(:game) }

    describe "completed" do
      it "should default to false" do
        expect(round.completed).to be false
      end
    end
  end

  describe "associations" do
    it { should belong_to(:game) }
    it { should belong_to(:player) }
    it { should have_many(:answers) }
  end

end
