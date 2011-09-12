# class TagProfileJob 
#   extend TagJob
#   @queue = :tag
#   
#   def self.get_taggable(id)
#     Profile.find(id)
#   end
#   
#   def self.tag(profile)   
#     import_tags_from(profile, profile.coder_profile)
#   end
# 
# end