class StackOverflowQuestionAddedEvent < ProfileEvent

  referenced_in :stack_overflow_question, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Knowledge"
    self.subcategory = "StackOverflow"
    self.date = stack_overflow_question.date 
  end

  def description
    %Q{asked "#{stack_overflow_question.title}?" on StackOverflow}
  end

  def icon_url
    "event_icons/stackoverflow_question.png"
  end
 
end
