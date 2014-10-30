# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  player_id  :integer
#  completed  :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

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
    it { should have_many(:answer_matches)}
  end

  describe "methods" do
    let(:round) { create(:round) }
    before do
      ("a".."c").each do |letter|
        round.game.answers.create(answer: letter)
      end
    end

    describe "checking guesses" do
      it "returns the appropriate answer object for a correct guess" do
        answer = round.answer_for_guess("a")
        expect(answer).to be_a(GameAnswer)
        expect(answer.answer).to eq("a")
      end

      it "creates an answer match object for a correct guess" do
        answer = round.answers.first
        expect(round.answer_matches).to receive(:create!).with(answer: answer)

        round.handle_guess(answer.answer)
      end

      it "does not return an answer if it's already been matched" do
        round.handle_guess("a")
        expect(round.answer_for_guess("a")).to be_nil
      end

    end

    describe "reporting gamestate" do
      it "reports the remaining number of answers to be found" do
        expect(round.answers_left).to be(3)
        round.handle_guess("a")
        expect(round.answers_left).to be(2)
      end

      it "reports the remaining time left in the game" do
        allow(round).to receive(:created_at).and_return(2.minutes.ago)
        expect(round.time_remaining).to be_within(0.5).of(0)
      end
    end
  end

end
