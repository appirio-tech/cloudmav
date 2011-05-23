
class TwitterService
  
  def self.sync(profile)
    client = Grackle::Client.new
    response = client.users.show? :screen_name=> profile.username

    profile.followers_count = response.followers_count
    # puts "response #{response.inspect}"
  end
  
  
  def get_tweets(profile)
    
    
  end
  
end