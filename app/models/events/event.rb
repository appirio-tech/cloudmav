class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category, :type => String
  field :subcategory, :type => String
  field :is_public, :type => Boolean, :default => false
  field :in_process, :type => Boolean, :default => false
  field :completed, :type => Boolean, :default => false
  field :subject_id, :type => String
  field :subject_class_name, :type => String
  field :date, :type => DateTime
  field :processed_date, :type => DateTime
  field :error_message, :type => String

  scope :pending, lambda { where(:in_process => false, :completed => false) }
  scope :public, lambda { where(:is_public => true) }
  scope :categorized_as, lambda { |cat| where(:category => cat) }
  scope :subcategorized_as, lambda { |cat| where(:subcategory => cat) }

  before_create :set_base_info
  after_create :add_to_jobs

  index :is_public
  index :completed
  index :in_process
  index :category
  index :subcategory

  def url?
    false
  end

  def set_base_info
    self.category = "Default"
    self.subcategory = "Default"
    set_info if respond_to? :set_info
  end

  def perform
    begin
    self.in_process = true
    self.date = self.created_at if self.date.nil?
    self.save

    do_work if self.respond_to? :do_work
        
    self.completed = true
    self.in_process = false
    self.processed_date = DateTime.now
    self.save
    rescue => detail
      self.error_message = detail.message
      self.save
    end
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end

  def subject_class
    Object.const_get(subject_class_name)
  end

  def subject
    subject_class.find(subject_id)
  end

  def icon_url
    "event_icons/default.png"
  end

  def description
    self.to_s
  end

end
