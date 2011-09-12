class ExperienceProfileTagEvent < TagEvent

  def set_tags
    taggable.profile.jobs.each do |job|
      job.tags.each do |t|
        tag t
      end
    end
  end

end
