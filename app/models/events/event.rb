class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category, :type => String

  referenced_in :profile, :inverse_of => :events

  before_create :set_category
  after_create :add_to_jobs

  def set_category
    category = "Default"
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end


end
