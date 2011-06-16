class BlogResyncEvent < BlogSyncEvent

  def before_sync
    PostAddedEvent.for_profile(profile).each do |e|
      if e.post.blog == blog
        e.destroy
      end
    end
    blog.posts.destroy_all
    profile.recalculate_score!
  end

end




