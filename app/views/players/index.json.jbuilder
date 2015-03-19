json.array!(@players) do |player|
  json.extract! player, :id, :player_id, :sport, :first_name, :last_name, :position, :age
  json.url player_url(player, format: :json)
end
