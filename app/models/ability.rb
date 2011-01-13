class Ability
  include CanCan::Ability

  def initialize(user)
    can [:set_speaker_rate_profile], Profile do |profile|
      user.profile == profile
    end
    can [:edit, :add_talk, :add_project, :add_blog], Profile do |profile|
      user.profile == profile
    end
    can [:edit, :add_presentation], Talk do |talk|
      user.profile == talk.profile
    end
    can [:edit, :add_post], Blog do |blog|
      user.profile == blog.profile
    end
  end
end