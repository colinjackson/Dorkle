class Session < ActiveRecord::Base

  validates_presence_of :user, :session_token
  validates_uniqueness_of :session_token

  after_initialize :ensure_session_token

  belongs_to :user, inverse_of: :sessions

  private
  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

  def generate_unique_session_token
    loop do
      token = SecureRandom.base64(16)
      return token unless Session.exists?(session_token: token)
    end
  end

end
