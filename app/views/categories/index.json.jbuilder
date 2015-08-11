json.data do
  json.array!(@categories) do |category|
    json.extract! category, :id, :name, :description, :enabled, :image_url
  end
end
