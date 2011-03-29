class StackOverflowQuestionAddedEvent < ProfileEvent

  referenced_in :stack_overflow_question, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
  end

  def description
    %Q{asked "#{stack_overflow_question.title}?" on StackOverflow}
  end

end
