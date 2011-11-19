class LinkedinProfile
  include Mongoid::Document  
  include CodeMav::Syncable
  
  field :url, :type => String
  field :last_synced, :type => DateTime

  belongs_to :profile
  embeds_one :linkedin_request
  embeds_many :linkedin_positions
  
  def create_linkedin_request!(request_token)   
    self.linkedin_request = LinkedinRequest.new(:request_token => request_token.token, :request_secret => request_token.secret)
    self.linkedin_request.save
    self.save
  end

  def create_linkedin_positions!
     client = self.linkedin_request.create_client!
     positions = client.profile(:fields => %w(positions)).positions.all
     self.linkedin_positions = []
     positions.each do |p|
       linkedin_position = LinkedinPosition.new(:linkedin_profile => self)
       linkedin_position.set_info_from_linkedin_position(p)
       linkedin_position.save
     end     
     self.save
   end

  def add_positions_from_linkedin!
    self.last_synced = DateTime.now
    self.linkedin_positions.each do |p|
      job = self.profile.jobs.where(:imported_id => p.imported_id).first
      if (job.nil?)
        job = Job.new
        job.profile = self.profile
      end
      p.set_info_on_job(job)
      job.save
    end
    self.profile.save
    self.save
  end

end
