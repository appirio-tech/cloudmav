require 'digest/sha1'

class SlideShare
  include HTTParty
  
  def self.find_talks_for(username)
    params = create_parameters
    params[:username_for] = username
    result = get("http://www.slideshare.net/api/2/get_slideshows_by_user", :query => params)
    result.parsed_response["User"]["Slideshow"]
  end
  
  private
    def self.create_parameters
      params = {}
      params[:api_key] = SLIDE_SHARE_API_KEY
      
      timestamp = Time.now.to_i
      ss_hash = Digest::SHA1.hexdigest (SLIDE_SHARE_SECRET + timestamp.to_s)
      
      params[:ts] = timestamp
      params[:hash] = ss_hash
      params[:format] = "json"
      return params
    end
  
end