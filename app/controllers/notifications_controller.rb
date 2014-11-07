class NotificationsController < ApplicationController
  before_filter :require_current_user_owner

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to :back
  end

  private
  def require_current_user_owner
    if !signed_in? || Notification.find(params[:id]).user_id != current_user.id
      redirect_to user_url(current_user)
    end
  end

end
