class StackOverflowProfileResyncEvent < StackOverflowProfileSyncEvent

  def before_sync
    StackOverflowQuestionAddedEvent.for_profile(profile).destroy_all
    StackOverflowAnswerAddedEvent.for_profile(profile).destroy_all

    stack_overflow_profile.questions.destroy_all
    stack_overflow_profile.answers.destroy_all
    profile.recalculate_score!
  end

end



