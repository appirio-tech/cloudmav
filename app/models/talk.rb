class Talk
  include Mongoid::Document
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :slides_thumbnail, :type => String
  field :imported_id, :type => String
  
  embedded_in :profile, :inverse_of => :talk
  embeds_many :presentations
  
  def add_presentation(presentation)
    self.profile.earn("for presentation", 20, :speaker_points)
  end
end