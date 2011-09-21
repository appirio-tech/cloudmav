class LinkToBitbucketRepositoriesController < LoggedInController
   before_filter :set_talk
   
   def new
     authorize! :sync_profile, @profile
     @bitbucket_repositories = @profile.bitbucket_profile.repositories.map{|t| [t.name, t._id.to_s] }
   end

   def create
     authorize! :sync_profile, @profile
     @talk.bitbucket_repository = BitbucketRepository.find(params[:bitbucket_repository_id])
     @talk.save
     redirect_to [@profile, @talk]
   end
   
   private

   def set_talk
     @talk = Talk.by_permalink(params[:talk_id]).first
   end
end