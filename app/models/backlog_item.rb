class BacklogItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Locatable

  field :title, :type => String
  field :description, :type => String

  validates_presence_of :title

end
