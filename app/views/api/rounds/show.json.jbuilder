json.(@round, :id, :completed, :start_time)

json.game do
  json.partial! 'api/games/game', game: @round.game
end

json.answers @round.answers do |answer|
  json.(answer, :id, :answer)
end

json.answer_matches @round.answer_matches do |answer_match|
  json.(answer_match, :id, :round_id, :answer_id)
end
