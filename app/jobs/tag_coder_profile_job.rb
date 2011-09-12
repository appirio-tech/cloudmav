class TagCoderProfileJob < TagJob
  
  def set_taggable(id)
    @taggable = CoderProfile.find(id)
  end
  
  def tag     
    import_tags_from(@taggable.profile.git_hub_profile)
  end

end