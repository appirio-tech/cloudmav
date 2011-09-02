When /^I add a video to a talk/ do
  visit edit_profile_talk_path(@profile, @talk)
  VCR.use_cassette("video with presentation", :record => :new_episodes) do  
    @talk = Factory.build(:talk)
    fill_in "talk_title", :with => @talk.title
    fill_in "talk_date_string", :with => "3/10/2010"
    fill_in "talk_time_string", :with => "8:30pm"
    fill_in "talk_video_url", :with => "http://www.viddler.com/explore/virtualaltnet/videos/180" 
    click_button "Save"
  end
end

Then /^the video should be added to the talk/ do
  talk = Talk.where(:title => @talk.title).first 
  talk.video_url.should_not be_nil
  talk.video?.should == true
end

