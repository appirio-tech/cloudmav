module StackOverflowHelper
  
  
  def stack_overflow_badges(profile)
    profile.badge_html.html_safe
  end
  
end