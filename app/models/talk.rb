require 'taggable'
require 'indexable'

class Talk
  include Mongoid::Document
  include CodeMav::Taggable
  include CodeMav::Indexable
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :slides_thumbnail, :type => String
  field :imported_id, :type => String
  field :tags, :type => Array, :default => []
  field :willing_to_give_talk_again, :type => Boolean, :default => false
  
  referenced_in :profile, :inverse_of => :talks
  embeds_many :presentations
  embeds_one :activity
  
  after_create :talk_added
  
  def talk_added
    profile.just(:added_talk, self, :category => :speaking)
  end
    
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