class StackOverflowAnswerAddedEvent < ProfileEvent

  referenced_in :stack_overflow_answer, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "StackOverflow"
    self.date = stack_overflow_answer.date
  end

  def description
    if stack_overflow_answer.accepted? 
      %Q{answered "#{stack_overflow_answer.title}" on StackOverflow}
    else
      %Q{posted an answer to "#{stack_overflow_answer.title}" on StackOverflow}
    end
  end

  def url?
    true
  end

  def url
    stack_overflow_answer.url
  end

  def icon_url
    "event_icons/stackoverflow_answer.png"
  end
 
end
