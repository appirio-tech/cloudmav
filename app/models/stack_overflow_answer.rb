class StackOverflowAnswer
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable

  referenced_in :stack_overflow_profile, :inverse_of => :answers

  field :title, :type => String
  field :question_id, :type => String
  field :answer_id, :type => String
  field :url, :type => String
  field :date, :type => DateTime
  field :accepted, :type => Boolean

  def accepted?
    accepted
  end

  def profile
    stack_overflow_profile.profile
  end

end

