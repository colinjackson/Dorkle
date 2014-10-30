# == Schema Information
#
# Table name: round_answer_matches
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe RoundAnswerMatch, :type => :model do
  describe "validates" do
    let!(:match) { create(:round_answer_match) }
    it { should validate_presence_of(:round) }
    it { should validate_presence_of(:answer) }

    it "should enforce uniqueness of answers per round" do
      new_match = RoundAnswerMatch.new({
        round: match.round, answer: match.answer
      })
      expect(new_match).not_to be_valid
    end

    it "should allow repeat answers for different rounds" do
      new_match = RoundAnswerMatch.new({
        round: create(:round), answer: match.answer
      })
      expect(new_match).to be_valid
    end
  end

  describe "associates" do
    it { should belong_to(:round) }
    it { should belong_to(:answer) }
  end
end
