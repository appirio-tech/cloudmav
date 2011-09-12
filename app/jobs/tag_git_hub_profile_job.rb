# class TagGitHubProfileJob
#   extend TagJob
#   @queue = :tag
#   
#   def self.get_taggable(git_hub_profile_id)
#     GitHubProfile.find(git_hub_profile_id)
#   end
#   
#   def self.tag(git_hub_profile)
#     git_hub_profile.repositories.each do |r|
#       unless r.language.blank?
#         git_hub_profile.tag r.language.downcase, :score => 10
#       end
#     end  
#   end
# 
# end