json.hot_games @hot_games do |game|
  json.partial! 'api/games/game', game: game
end

json.best_players @best_players do |player|
  json.(player, :id, :username, :name, :total_answered, :created_games_play_count)
  json.email player.email if player == current_user
  json.image_url_show player.image.url(:show)
  json.image_url_thumb player.image.url(:thumb)
end

json.best_authors @best_authors do |author|
  json.(author, :id, :username, :name, :total_answered, :created_games_play_count)
  json.email author.email if author == current_user
  json.image_url_show author.image.url(:show)
  json.image_url_thumb author.image.url(:thumb)
end
