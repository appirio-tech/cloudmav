class Talk
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Indexable
  include CodeMav::Eventable
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :slides_thumbnail, :type => String
  field :imported_id, :type => String
  field :willing_to_give_talk_again, :type => Boolean, :default => false
  
  referenced_in :profile, :inverse_of => :talks
  references_many :presentations, :inverse_of => :talk
    
  def self.search(query, options = {})
    search = Sunspot.new_search(Talk)
    search.build do
      keywords query do
      end
    end
    search.execute
  end

  def related_items
    [profile.speaker_profile]
  end

end
