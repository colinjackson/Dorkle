json.(@round, :id, :completed, :start_time)

json.game do
  json.partial! 'api/games/game', game: @round.game
end

json.answers @round.answers do |answer|
  json.(answer, :id, :answer)
end
