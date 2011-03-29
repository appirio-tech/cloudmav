class StackOverflowQuestion 
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable

  referenced_in :stack_overflow_profile, :inverse_of => :questions

  field :title, :type => String
  field :question_id, :type => String
  field :url, :type => String
  field :date, :type => DateTime

  def profile
    stack_overflow_profile.profile
  end

end
