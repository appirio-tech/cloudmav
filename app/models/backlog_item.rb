class BacklogItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Eventable
  include CodeMav::Locatable

  field :title, :type => String
  field :description, :type => String
  field :url, :type => String
  field :imported_id, :type => String
  field :imported_from, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime

  validates_presence_of :title

  referenced_in :author, :class_name => "Profile", :inverse_of => :backlog_items

  def url?
    !url.blank?
  end

  def imported?
    !imported_from.blank?
  end

  class << self

    def search(query)
      search = Sunspot.new_search(BacklogItem)
      search.build do
        keywords profile.all_tags do
          boost_fields :title => 1.5
        end
      end
      search.execute
    end

  end

end
