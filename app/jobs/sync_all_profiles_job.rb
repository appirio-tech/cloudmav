class SyncAllProfilesJob
  @queue = :sync
  
  def self.perform
    Profile.sync_all!
  end

end