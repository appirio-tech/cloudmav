class ProfileTagEvent < TagEvent

  def set_tags

    @profile = taggable

    import_tags_from(@profile.experience_profile)
    import_tags_from(@profile.knowledge_profile)
    import_tags_from(@profile.speaker_profile)
    import_tags_from(@profile.coder_profile)

  end

end
