class LinkToGitHubRepositoriesController < LoggedInController
   before_filter :set_talk
   
   def new
     authorize! :sync_profile, @profile
     @git_hub_repositories = @profile.git_hub_profile.repositories.map{|t| [t.name, t._id.to_s] }
   end

   def create
     authorize! :sync_profile, @profile
     @talk.git_hub_repository = GitHubRepository.find(params[:git_hub_repository_id])
     @talk.save
     redirect_to [@profile, @talk]
   end
   
   private

   def set_talk
     @talk = Talk.by_permalink(params[:talk_id]).first
   end
end