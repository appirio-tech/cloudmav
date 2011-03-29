class StackOverflowAnswer
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :stack_overflow_profile, :inverse_of => :answers

  field :title, :type => String
  field :question_id, :type => String
  field :answer_id, :type => String
  field :url, :type => String
  field :date, :type => DateTime
  field :accepted, :type => Boolean

end

