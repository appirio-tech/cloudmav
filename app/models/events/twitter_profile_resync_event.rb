class TwitterProfileResyncEvent < TwitterProfileSyncEvent

  def before_sync
    #profile.recalculate_score!
  end

end


