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
  include Rails.application.routes.url_helpers

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
    if self.event == :created_game_played
      player = self.notifiable.player
      name = player ? player.getName : "Someone"
      "#{name} played your game!"
    elsif self.event == :new_challenge
      name = self.notifiable.challenger.getName
      "#{name} challenged you!"
    else
      "Something happened, but Dorkle doesn't know what!"
    end
  end

  def url
    if self.event == :created_game_played
      game_url(self.notifiable.game)
    else
      root_url
    end
  end

  def event
    EVENTS[self.event_id]
  end

  private
  def default_url_options
    {host: Rails.env.production? ? "playdorkle.com" : "localhost:3000"}
  end

end
