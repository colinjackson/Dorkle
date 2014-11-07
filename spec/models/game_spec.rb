# == Schema Information
#
# Table name: games
#
#  id                     :integer          not null, primary key
#  title                  :string(255)      not null
#  subtitle               :string(255)
#  source                 :string(255)      not null
#  time_limit             :integer          not null
#  author_id              :integer          not null
#  created_at             :datetime
#  updated_at             :datetime
#  image_file_name        :string(255)
#  image_content_type     :string(255)
#  image_file_size        :integer
#  image_updated_at       :datetime
#  rounds_count           :integer
#  completed_rounds_count :integer
#  answer_matches_count   :integer
#

require 'rails_helper'
require 'necessary_and_unique_attribute'

RSpec.describe Game, :type => :model do

  describe "validates" do
    describe "title" do
      it_behaves_like "a necessary and unique attribute", :game, :title
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

  describe "associates" do
    it { should belong_to(:author) }
    it { should have_many(:answers) }
    it { should have_many(:rounds) }
  end

  describe "returns a subtitle or placeholder text" do
    it "should return a subtitle if it has one" do
      game = create(:game, subtitle: "Can you do this thing?")
      expect(game.get_subtitle).to eq("Can you do this thing?")
    end

    it "should return placeholder text if it does not (or if it's empty)" do
      expect(create(:game).get_subtitle).to eq("(no subtitle)")
    end
  end

  describe "formats its source value" do
    # default source: http://www.ruby-doc.org/core-2.1.4/Array.html
    let(:game) { create(:game) }

    it "should reformat web urls to include their scheme" do
      newGame = create(:game, source: "www.google.com/")
      expect(newGame.source).to eq("http://www.google.com/")
    end

    it "should not alter urls that include their scheme explicitly" do
      expect(game.source).to eq("http://www.ruby-doc.org/core-2.1.4/Array.html")
    end

    it "returns just the hostname when asked" do
      expect(game.get_source_host).to eq("www.ruby-doc.org")
    end

    it "truncates overly long hostnames" do
      longHostname = "www.thisisanexcessivelylonghostnamewhatthehellwhywouldyouevenbuythisdomainnamewhatiswrongwithyou.com"
      newGame = create(:game, source: "http://#{longHostname}/info")
      expect(newGame.get_source_host).to eq(longHostname[0, 25])
    end
  end

end
