class BlogUnsyncEvent < UnsyncEvent
  referenced_in :blog, :inverse_of => :events

  def other_work
    BlogAddedEvent.for_profile(profile).each do |e|
      e.destroy
    end
    BlogSyncEvent.for_profile(profile).each do |e|
      e.destroy
    end
    PostAddedEvent.for_profile(profile).each do |e|
      e.destroy
    end
    blog.posts.destroy_all
  end

  def remove_badges
    remove_badge("iBlog")
  end

end


