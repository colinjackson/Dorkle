json.(game, :id, :title, :subtitle, :source, :time_limit)
json.source_host game.get_source_host
json.image_url_show game.image.url(:show)
json.image_url_thumb game.image.url(:thumb)

json.author do
  json.(game.author, :id, :name, :username, :email)
end
