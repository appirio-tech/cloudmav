# class TagCoderProfileJob 
#   extend TagJob
#   @queue = :tag
#   
#   def self.get_taggable(id)
#     CoderProfile.find(id)
#   end
#   
#   def self.tag(coder_profile)
#     import_tags_from(coder_profile, coder_profile.profile.git_hub_profile)
#   end
# 
# end