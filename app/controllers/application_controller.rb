class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :current_session, :signed_in?

  def current_user
    current_session ? current_session.user : nil
  end

  def current_session
    return nil if !session[:token]
    @current_session ||=
        Session.includes(:user).find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_session
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

  def require_signed_in
    if !signed_in?
      flash[:errors] = ["You need to be logged in to do that!"]
      redirect_to new_session_url
    end
  end

  def require_signed_out
    if signed_in?
      flash[:successes] = ["You're already signed in, silly!"]
      redirect_to user_url(current_user)
    end
  end

end
