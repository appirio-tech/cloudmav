class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category, :type => String
  field :public, :type => Boolean
  field :in_process, :type => Boolean, :default => false
  field :completed, :type => Boolean, :default => false

  scope :pending, lambda { where(:in_process => false, :completed => false) }

  before_create :set_info
  after_create :add_to_jobs

  def set_info
    self.category = "Default"
  end

  def perform
    self.in_process = true
    self.save

    do_work if self.respond_to? :do_work
        
    self.completed = true
    self.save
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end

end
