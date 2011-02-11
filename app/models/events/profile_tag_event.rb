class ProfileTagEvent < TagEvent

  def set_tags

    if taggable.stack_overflow_profile
      taggable.stack_overflow_profile.taggings.each do |tagging|
        tag tagging.tag.name, :count => tagging.count
      end
    end

  end

end
