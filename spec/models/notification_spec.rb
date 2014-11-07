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

  describe "generates text" do

    context "for when a user's created game is played" do
      it "should return a properly formatted string" do
        gameplay_notification = create :notification,
          event_id: Notification::EVENT_IDS[:created_game_played]

        expected_gameplay_text = "Someone played your game!"

        expect(gameplay_notification.text).to eq(expected_gameplay_text)
      end

    end
  end

end
