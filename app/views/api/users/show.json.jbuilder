json.(@user, :id, :username, :name)

json.email @user.email if @user == current_user

json.created_games @user.created_games do |game|
  json.partial! "api/games/game", game: game
end
