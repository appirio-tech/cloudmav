namespace :fix do    

  desc "Fix talks after getting rid of presentations"
  task :talks => :environment do
    profiles = Profile.all.to_a

    profiles.each do |p|
      if p.slide_share_profile
        response = SlideShare.get_slideshows_by_user(p.slide_share_profile.slide_share_username)

        slideshows = response["User"]["Slideshow"]
        slideshows = [slideshows] if slideshows.is_a?(Hash)

        slideshows.each do |ss_talk|
          talk = Talk.where(:imported_id => ss_talk["ID"]).first
          if talk
            talk.update_attributes(
              :title => ss_talk["Title"],
              :description => ss_talk["Description"],
              :imported_id => ss_talk["ID"],
              :imported_from => "SlideShare",
              :presentation_date => DateTime.parse(ss_talk["Created"]),
              :talk_creation_date => DateTime.parse(ss_talk["Created"]),
              :slides_url => ss_talk["DownloadUrl"],
              :slides_thumbnail => ss_talk["ThumbnailURL"],
              :slideshow_html => ss_talk["Embed"])
          end
        end
        p.slide_share_profile.url = "http://www.slideshare.net/#{p.slide_share_profile.slide_share_username}"
        p.slide_share_profile.slides_count = response["User"]["Slideshow"].count
        p.save!
        p.slide_share_profile.save! 
      end

      if p.speaker_rate_profile
        speaker = SpeakerRate.get_speaker(p.speaker_rate_profile.speaker_rate_id)
        p.speaker_rate_profile.rating = speaker["rating"]
        p.speaker_rate_profile.url = "http://speakerrate.com/speakers/#{p.speaker_rate_profile.speaker_rate_id}"

        speaker["talks"].each do |sr_talk| 
          talk = Talk.where(:imported_id => sr_talk["id"]).first
          if talk
            talk.update_attributes(
              :title => sr_talk["title"],
              :description => sr_talk["info"]["text"],
              :slides_url => sr_talk["slides_url"],
              :imported_id => sr_talk["id"],
              :imported_from => "SpeakerRate",
              :speaker_rating => sr_talk["rating"],
              :presentation_date => DateTime.parse(sr_talk["when"]),
              :talk_creation_date => DateTime.parse(sr_talk["when"])) 
          end
        end
        p.speaker_rate_profile.save 
      end
    end
  end

end
