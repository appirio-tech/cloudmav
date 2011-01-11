class Talk
  include Mongoid::Document
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :slides_thumbnail, :type => String
  field :imported_id, :type => String
  
  referenced_in :profile, :inverse_of => :talks
  embeds_many :presentations
  
  def add_presentation(presentation)
    self.profile.earn("for presentation", 20, :speaker_points)
  end
  
  def self.search(query, options = {})
    search = Sunspot.new_search(Talk)
    search.build do
      keywords query do
      end
    end
    search.execute
  end

end