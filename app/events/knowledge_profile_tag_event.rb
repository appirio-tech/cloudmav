class KnowledgeProfileTagEvent < TagEvent

  def set_tags
    @profile = taggable.profile

    import_tags_from(@profile.stack_overflow_profile) 
  end

end

