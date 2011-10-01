class SyncBitbucketProfileJob
  @queue = :sync
  
  def self.perform(id)
    bitbucket_profile = BitbucketProfile.find(id)
    profile = bitbucket_profile.profile
    user_info = BitbucketApi.get_user(bitbucket_profile.username)

    repositories = user_info["repositories"]

    read_repositories(bitbucket_profile, repositories) unless repositories.nil?

    bitbucket_profile.followers_count = bitbucket_profile.repositories.inject(0){|sum, r| sum + r.followers_count}
    bitbucket_profile.repository_count = bitbucket_profile.repositories.count
    bitbucket_profile.url = "http://www.bitbucket.org/#{bitbucket_profile.username}"
    bitbucket_profile.last_synced_date = DateTime.now
    bitbucket_profile.save
    
    profile.award_badge("Bucketeer", :description => "For having a Bitbucket account")

    bitbucket_profile.retag!
    profile.calculate_score! 
  end
  
  def self.read_repositories(bitbucket_profile, repositories)
    repositories.each do |r|
      repo = find_or_initialize_repo(bitbucket_profile, r)
      repo.url = "http://bitbucket.org/#{bitbucket_profile.username}/#{r["slug"]}"
      repo.description = r["description"]
      repo.followers_count = r["followers_count"]
      repo.save
    end
  end

  def self.find_or_initialize_repo(bitbucket_profile, bb_repo)
    repo = bitbucket_profile.repositories.where(:name => bb_repo["name"]).first
    unless repo
      repo = BitbucketRepository.new(:name => bb_repo["name"])
      repo.bitbucket_profile = bitbucket_profile
    end
    repo
  end
end