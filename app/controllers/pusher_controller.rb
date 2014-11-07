class PusherController < ApplicationController
  protect_from_forgery except: :auth

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render json: response
    else
      render json: {"Pusher don't do it" => "it's a trap!"}
    end
  end
end
