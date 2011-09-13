class UnsyncStackOverflowProfileJob
  @queue = :sync
  
  def self.perform(id)
    stack_overflow_profile = StackOverflowProfile.find(id)        
    profile = stack_overflow_profile.profile
    
    stack_overflow_profile.questions.destroy_all
    stack_overflow_profile.answers.destroy_all
    stack_overflow_profile.destroy
    
    profile.remove_badge("Stack Junkie")
    profile.remove_badge("I'm kind of a Big Deal")
    profile.calculate_score!
  end

end