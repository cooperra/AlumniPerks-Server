json.array!(@perks) do |perk|
  json.extract! perk, :id
  json.url perk_url(perk, format: :json)
end
