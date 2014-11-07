class NotificationsController < ApplicationController

  def update
    @notification = Notification.find(params[:id])
    if @notification.update(notification_params)
      redirect_to :back
    else
      flash[:errors] = ["Ruh-roh!"] + @notification.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to :back
  end

  private
  def notification_params
    params.require(:notification).permit(:is_read)
  end

end
