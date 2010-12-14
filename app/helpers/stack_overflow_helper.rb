module StackOverflowHelper
  
  
  def stack_overflow_badges(profile)
    return "" if profile.badge.nil?
    profile.badge_html.html_safe
  end
  
end