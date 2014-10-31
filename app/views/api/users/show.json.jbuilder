json.(@user, :id, :username, :name)

if (@user == current_user) {
  json.email @user.email
}

json.games @user.created_games do |game|
  json.(game, :id, :title, :subtitle, :source, :time_limit)
end
