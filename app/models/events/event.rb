class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category, :type => String
  field :public, :type => Boolean
  field :in_process, :type => Boolean, :default => false
  field :completed, :type => Boolean, :default => false

  referenced_in :profile, :inverse_of => :events

  before_create :set_info
  after_create :add_to_jobs

  def set_info
    self.category = "Default"
  end

  def perform
    self.in_process = true
    self.save

    do_work if self.respond_to? :do_work
    score_points if self.respond_to? :score_points
    award_badges if self.respond_to? :award_badges
    profile.save

    self.completed = true
    self.save
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end


end
