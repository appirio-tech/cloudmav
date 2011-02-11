class SynchedStackOverflowEvent < SynchEvent

  referenced_in :stack_overflow_profile, :inverse_of => :events

  def do_work
    stack_overflow_profile.retag!
  end

  def award_badges
    if stack_overflow_profile.reputation > 10000
      profile.award_badge("I'm kind of a Big Deal", :description => "For having a StackOverflow reputation over 10k")
    end
  end

end
