class StackOverflowProfileUnsyncEvent < UnsyncEvent
  referenced_in :stack_overflow_profile, :inverse_of => :events

  def other_work
    StackOverflowProfileAddedEvent.for_profile(profile).destroy_all
    StackOverflowProfileSyncEvent.for_profile(profile).destroy_all
    StackOverflowQuestionAddedEvent.for_profile(profile).destroy_all
    StackOverflowAnswerAddedEvent.for_profile(profile).destroy_all
    stack_overflow_profile.questions.destroy_all
    stack_overflow_profile.answers.destroy_all
  end

  def remove_badges
    remove_badge("Stack Junkie")
    remove_badge("I'm kind of a Big Deal")
  end

end



