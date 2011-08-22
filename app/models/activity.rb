class Activity  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :category, :type => String
  referenced_in :profile, :inverse_of => :activities
  
  field :subject_type, :type => String
  field :subject_id, :type => BSON::ObjectId
    
  def subject
    @subject ||= if subject_type && subject_id
      subject_type.constantize.find(subject_id)
    end
  end

  def subject=(subject)
    self.subject_type = subject.class.name
    self.subject_id   = subject.id
  end
end