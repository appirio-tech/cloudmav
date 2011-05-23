require 'net/http'
require 'net/https'
require 'json'

class BitBucketService
  
  def self.sync(profile)
    # url = URI.parse("https://api.bitbucket.org/1.0/users/#{profile.username}")
    # 
    # response = Net::HTTP.get_response url
    # result = JSON.parse(response.body)
    
    # Net::HTTP.start("https://api.bitbucket.org/1.0/users/") {|http|
    #       req = Net::HTTP::Get.new("#{profile.username}")
    #       req.basic_auth 'rookieone', 'pennyM00n'
    #       response = http.request(req)
    #       print response.body
    #     }

    url = URI.parse("https://api.bitbucket.org/1.0/users/#{profile.username}")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      req.basic_auth 'rookieone', 'pennyM00n'
      response = http.request(req)
      print response.body
    }
        
    profile.url = "https://bitbucket.org/#{profile.username}"    
    profile.repository_count = result["repositories"].count
    followers_count = 0
    result["repositories"].each{|r| followers_count += r["followers_count"].to_i }
    profile.followers_count = followers_count
  end
  
end