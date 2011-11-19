class ResyncStackOverflowProfileJob
  @queue = :sync
  
  def self.perform(id)
    stack_overflow_profile = StackOverflowProfile.find(id)

    stack_overflow_profile.questions.destroy_all
    stack_overflow_profile.answers.destroy_all
    
    stack_overflow_profile.sync!
  end

end