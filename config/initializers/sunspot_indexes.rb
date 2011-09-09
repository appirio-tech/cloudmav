#
#Sunspot.setup(Talk) do
#  text :title
#  text :description
#  text :all_tags 
#end
#
#Sunspot.setup(Profile) do
#  text :username
#  text :name
#  text :all_tags
#  text :location
#  location :coordinates do
#    Sunspot::Util::Coordinates.new(lat, lng) if [lat, lng].all?
#  end
#end
#
#Sunspot.setup(Company) do
#  text :name
#  text :all_tags
#end
#
#Sunspot.setup(BacklogItem) do
#  text :title
#  text :description
#  time :start_date
#  time :end_date
#  text :all_tags
#end
