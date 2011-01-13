
Sunspot.setup(Talk) do
  text :title
  text :description
  text :all_tags 
end

Sunspot.setup(Profile) do
  text :username
  text :name
  text :tags
end