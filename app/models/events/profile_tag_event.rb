class ProfileTagEvent < TagEvent

  def set_tags

    @profile = taggable

    import_tags_from(@profile.experience_profile)
    import_tags_from(@profile.speaker_profile)
    import_tags_from(@profile.stack_overflow_profile) if @profile.stack_overflow_profile

  end

end
