object @profile
attributes :username, :name, :total_score, :location

code(:gravatar_url) { |p| p.gravatar_url }

unless @profile.stack_overflow_profile.nil?
  child :stack_overflow_profile do
    attributes :stack_overflow_id, :reputation, :url
  end
end

unless @profile.git_hub_profile.nil?
  child :git_hub_profile do
    attributes :username, :url
  end
end

unless @profile.bitbucket_profile.nil?
  child :bitbucket_profile do
    attributes :username, :url
  end
end

unless @profile.speaker_rate_profile.nil?
  child :speaker_rate_profile do
    attributes :speaker_rate_id, :rating, :url
  end
end

unless @profile.speaker_rate_profile.nil?
  child :speaker_rate_profile do
    attributes :slide_share_username, :url
  end
end

