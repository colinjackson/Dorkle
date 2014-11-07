# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notifiable_id   :integer
#  notifiable_type :string(255)
#  event_id        :integer
#  is_read         :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Notification, :type => :model do

  include Rails.application.routes.url_helpers
  def default_url_options
    {host: Rails.env.production? ? "playdorkle.com" : "localhost:3000"}
  end

  describe "validates" do

    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notifiable) }
    it { should validate_presence_of(:event_id) }
    it do
      should validate_inclusion_of(:event_id)
        .in_array(Notification::EVENTS.keys)
    end
  end

  describe "associates" do
    it { should belong_to(:user) }
    it { should belong_to(:notifiable) }
  end

  context "for when a user's created game is played" do
    let(:notification) do
      create(:notification, event_id: 1, notifiable: create(:round))
    end

    it "should return a properly formatted string" do
      expected_gameplay_text = "Someone played your game!"
      expect(notification.text).to eq(expected_gameplay_text)
    end

    it "should generate the game's url" do
      expected_url = game_url(notification.notifiable.game)
      expect(notification.url).to eq(expected_url)
    end

  end


end
