class StackOverflowAnswerAddedEvent < ProfileEvent

  referenced_in :stack_overflow_answer, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
  end

  def description
    if stack_overflow_answer.accepted? 
      %Q{answered "#{stack_overflow_answer.title}" on StackOverflow}
    else
      %Q{posted an answer to "#{stack_overflow_answer.title}" on StackOverflow}
    end
  end

end
