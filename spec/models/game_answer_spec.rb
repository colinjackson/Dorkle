require 'rails_helper'

RSpec.describe GameAnswer, :type => :model do
  describe "validates" do
    let!(:game_answer) { create(:game_answer) }
    it { should validate_presence_of(:game) }
    it { should validate_presence_of(:answer) }

    it "should enforce uniquess of answers per game" do
      next_answer = GameAnswer.new({
        game: game_answer.game,
        answer: game_answer.answer
      })

      expect(next_answer).not_to be_valid
    end

    it "doesn't care about answer case" do
      next_answer = GameAnswer.new({
        game: game_answer.game,
        answer: game_answer.answer.swapcase
      })

      expect(next_answer).not_to be_valid
    end
  end
end
