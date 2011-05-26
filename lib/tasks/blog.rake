namespace :blog do    

  desc "fix blog"
  task :fix => :environment do
    Post.destroy_all
    PostAddedEvent.destroy_all

    Blog.all.each do |blog|
      if blog.rss.blank?
        blog.rss = blog.url
        blog.save
      end
      blog.sync!
    end
  end

end

