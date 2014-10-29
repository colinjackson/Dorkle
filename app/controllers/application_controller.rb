class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
    current_session ? current_session.user : nil
  end

  def signed_in?
    !!current_user
  end

  private
  def sign_in!(user)
    @current_user = user
    session[:token] = user.sessions.create!.session_token
  end

  def sign_out!
    current_session && current_session.destroy
    session[:token] = nil
  end

  def current_session
    return nil if !session[:token]
    @current_session ||=
        Session.includes(:user).find_by_session_token(session[:token])
  end



end
