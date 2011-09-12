class CoderProfileTagEvent < TagEvent

  def set_tags
    @profile = taggable.profile

    import_tags_from(@profile.git_hub_profile)
  end

end
