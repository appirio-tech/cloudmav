require 'net/http'
require 'json'

class SpeakerRateService
  
  def self.sync(speaker_rate_profile)
    url = URI.parse("http://speakerrate.com/speakers/#{speaker_rate_profile.speaker_rate_id}.json")
    
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)
    
    speaker_rate_profile.url = "http://speakerrate.com/speakers/#{speaker_rate_profile.speaker_rate_id}"
    speaker_rate_profile.rating = result["average_rating"]
    
    result["talks"].each do |sr_talk|
      talk = create_talk(sr_talk)
      speaker_rate_profile.profile.talks << talk
    end
  end
  
  private
    def self.create_talk(sr_talk)
      talk = Talk.new
      talk.title = sr_talk["title"]
      talk.description = sr_talk["info"]["text"]
      talk.slides_url = sr_talk["slides_url"]
      talk.presentations << Presentation.new(:presentation_date => DateTime.parse(sr_talk["when"]))
      return talk
    end
  
end