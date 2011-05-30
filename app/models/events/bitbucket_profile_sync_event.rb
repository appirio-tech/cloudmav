class BitbucketProfileSyncEvent < SyncEvent
  referenced_in :bitbucket_profile, :inverse_of => :events

  def find_or_initialize_repo(bb_repo)
    repo = bitbucket_profile.repositories.where(:name => bb_repo["name"]).first
    unless repo
      repo = BitbucketRepository.new(:name => bb_repo["name"])
      repo.bitbucket_profile = bitbucket_profile
    end
    repo
  end

  def sync
    user_info = BitbucketApi.get_user(bitbucket_profile.username)

    user_info["repositories"].each do |r|
      repo = find_or_initialize_repo(r)
      repo.url = r["url"]
      repo.description = r["description"]
      repo.followers_count = r["followers_count"]
      repo.save
    end

    bitbucket_profile.followers_count = bitbucket_profile.repositories.inject(0){|sum, r| sum + r.followers_count}
    bitbucket_profile.repository_count = bitbucket_profile.repositories.count
    bitbucket_profile.url = "http://www.bitbucket.org/#{bitbucket_profile.username}"
    bitbucket_profile.save

    bitbucket_profile.retag!
  end

end

