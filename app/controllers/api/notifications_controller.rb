module Api
  class NotificationsController < ApplicationController

    def index
      @notifications = User.find(params[:user_id]).notifications.unread
        .includes(:notifiable)
      render :index
    end

    def update
      @notification = Notification.find(params[:id])
      if @notification.update(notification_params)
        render :show
      else
        render { errors: @notification.errors.full_messages },
          status: :unprocessable_entity
      end
    end

    def destroy
      @notification = Notification.find(params[:id])
      @notification.destroy
      render json: {}
    end

    private
    def notification_params
      params.require(:notification).permit(:is_read)
    end

    def require_current_user_owner
      forbidden = false

      forbidden ||= !signed_in?
      unless forbidden
        if params[:action] == "index"
          user = User.find(params[:game_id])
        else
          user = Notification.find(params[:id]).user
        end

        forbidden = current_user != user
      end

      forbidden ? render json: { "you are a": "bad person"}, status: :forbidden
    end

  end
end
