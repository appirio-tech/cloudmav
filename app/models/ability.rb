class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?
    return if user.profile.nil?
    
    can :tweet, Profile do |profile|
      user.profile == profile
    end
    can :view_widgets, Profile do |profile|
      user.profile == profile
    end
    can :sync_profile, Profile do |profile|
      user.profile == profile
    end
    can [:set_speaker_rate_profile, :set_slide_share_profile, :set_stack_overflow_profile, :set_git_hub_profile], Profile do |profile|
      user.profile == profile
    end
    can [:set_linked_in_profile], Profile do |profile|
      user.profile == profile
    end
    if user.profile.can_manage_tags?
      can [:manage], Tag 
    end
    can [:manage_jobs], Profile do |profile|
      user.profile == profile
    end
    if user.profile.moderator?
      can [:edit], Company
      can [:manage], Technology
    end
    
    can [:set_speaker_bio], Profile do |profile|
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
    can [:create], BacklogItem
    can [:edit], BacklogItem do |backlog_item|
      user.profile == backlog_item.author
    end

    can [:follow], Profile do |profile|
      user.profile != profile
    end

    can [:view], "Board"
  end
end
