class BacklogItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Locatable

  field :title, :type => String
  field :description, :type => String

  validates_presence_of :title
  validates_presence_of :author

  referenced_in :author, :class_name => "Profile", :inverse_of => :backlog_items

end
