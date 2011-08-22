object @profile
attributes :username, :name

code(:tags) do |p|
  @profile.taggings.map{|t| { "name" => t.tag.name, "count" => t.count, "score" => t.score }}
end


