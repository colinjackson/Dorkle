json.(game, :id, :title, :subtitle, :source, :time_limit)

json.author do
  json.(game.author, :id, :name, :username, :email)
end
