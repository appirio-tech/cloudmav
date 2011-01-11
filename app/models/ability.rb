class Ability
  include CanCan::Ability

  def initialize(user)
    can [:add_presentation, :edit], Talk do |talk|
      user.profile.talks.include? talk
    end
  end
end