json.(@user, :id, :username, :name)
json.email @user.email if @user == current_user
json.image_url_show @user.image.url(:show)
json.image_url_thumb @user.image.url(:thumb)

json.created_games @user.created_games do |game|
  json.partial! "api/games/game", game: game
end
