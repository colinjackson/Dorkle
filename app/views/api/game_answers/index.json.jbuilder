json.array! @game.answers do |answer|
  json.(answer, :id, :answer)
  json.regex answer.get_regex
end
