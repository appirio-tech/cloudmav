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
    
    def recommended_items_for_profile(profile)
      results = BacklogItem.all.map{|i| {:item => i, :score => 0} }

      results.each do |r|
        profile.taggings.each do |t|
          if r[:item].has_tag?(t.tag)
            r[:score] += t.score * 10
          end
        end

        if r[:item].start_date
          start_date = r[:item].start_date
          r[:score] += 30 if start_date <= 1.week.from_now
          r[:score] += 20 if start_date <= 2.weeks.from_now
          r[:score] += 10 if start_date <= 1.month.from_now
        end
      end

      results.sort {|x,y| y[:score] <=> x[:score] }.map{|r| r[:item]}[0..9]
    end

  end

end
