json.(@round, :id, :completed, :created_at)

json.game do
  json.partial! 'api/games/game', game: @round.game
end

json.answers @round.answers do |answer|
  json.(answer, :id, :answer)
end
