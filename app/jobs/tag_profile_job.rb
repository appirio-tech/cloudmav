class TagProfileJob < TagJob
  
  def set_taggable(id)
    @taggable = Profile.find(id)
  end
  
  def tag     
    import_tags_from(@taggable.coder_profile)
  end

end