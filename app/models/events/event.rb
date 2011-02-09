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

  def perform
    do_work if self.respond_to? :do_work
    score_points if self.respond_to? :score_points
    award_badges if self.respond_to? :award_badges
    profile.save
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end


end
