require 'net/http'
require 'json'

class SpeakerRateService
  
  def self.synch(profile)
    url = URI.parse("http://speakerrate.com/speakers/#{profile.speaker_rate_id}.json")
    
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)
    
    profile.url = "http://speakerrate.com/speakers/#{profile.speaker_rate_id}"
    profile.rating = result["average_rating"]
  end
  
end