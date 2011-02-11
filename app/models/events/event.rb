class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category, :type => String
  field :is_public, :type => Boolean, :default => false
  field :in_process, :type => Boolean, :default => false
  field :completed, :type => Boolean, :default => false
  field :subject_id, :type => String
  field :subject_class_name, :type => String

  scope :pending, lambda { where(:in_process => false, :completed => false) }

  before_create :set_base_info
  after_create :add_to_jobs

  def set_base_info
    self.category = "Default"
    set_info if respond_to? :set_info
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

  def subject_class
    Kernel.const_get(subject_class_name)
  end

  def subject
    subject_class.find(subject_id)
  end

end
