class SpeakerRate
  include HTTParty
  
  def self.get_speaker_info(speaker_rate_id)
    result = get("http://speakerrate.com/speakers/#{speaker_rate_id}.json")
    result.parsed_response["talks"]
  end
    
end