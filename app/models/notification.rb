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

class Notification < ActiveRecord::Base

  EVENTS = {
    1 => :created_game_played,
    2 => :new_challenge
  }

  EVENT_IDS = EVENTS.invert

  validates_presence_of :user, :notifiable, :event_id
  validates_inclusion_of :event_id, in: EVENTS.keys

  belongs_to :notifiable, polymorphic: true
  belongs_to :user, inverse_of: :notifications

  def text
    if EVENTS[self.event_id] == :created_game_played
      player = self.notifiable.player
      name = player ? player.getName : "Someone"
      "#{name} played your game!"
    elsif EVENTS[self.event_id] == :new_challenge
      name = self.notifiable.challenger.getName
      "#{name} challenged you!"
    else
      "Something happened, but Dorkle doesn't know what!"
    end
  end

end
