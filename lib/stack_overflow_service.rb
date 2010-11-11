require 'net/http'
require 'json'

class StackOverflowService
  
  def self.synch(profile)
    # http://meta.stackoverflow.com/users/flair/{id}.{format}
    url = URI.parse("http://stackoverflow.com/users/flair/#{profile.stack_overflow_id}.json")
    
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)
    
    profile.url = result["profileUrl"]
    profile.reputation = result["reputation"].sub!(",","").to_i
    profile.badge_html = result["badgeHtml"]
  end
  
end