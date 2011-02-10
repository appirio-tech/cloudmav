class TagEvent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :taggable_id, :type => String
  field :class_name, :type => String
  field :in_process, :type => Boolean, :default => false
  field :completed, :type => Boolean, :default => false

  scope :pending_for, lambda { |id| where(:object_id => id) }

  after_create :add_to_jobs

  def perform
    self.in_process = true
    self.save

    if Kernel.const_defined?(class_name)
      model = Kernel.const_get(class_name)
      o = model.find(taggable_id)
      o.calculate_tags!
    end

    self.completed = true
    self.save
  end

  def add_to_jobs
    Delayed::Job.enqueue self 
  end


end
