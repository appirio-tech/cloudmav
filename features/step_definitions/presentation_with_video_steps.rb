When /^I add a video to a presentation$/ do
  visit new_talk_presentation_path(@talk)
  VCR.use_cassette("video with presentation", :record => :new_episodes) do  
    @presentation = Factory.build(:presentation)
    fill_in "presentation_date", :with => "3/10/2010"
    fill_in "presentation_time", :with => "8:30pm"
    fill_in "presentation_audience", :with => @presentation.audience
    fill_in "presentation_url", :with => @presentation.url
    fill_in "presentation_video_url_input", :with => "http://www.viddler.com/explore/virtualaltnet/videos/180" 
    click_button "Schedule Presentation"
  end
end

Then /^the video should be added to the presentation$/ do
  presentation = Presentation.where(:url => @presentation.url).first 
  presentation.video.should_not be_nil
  presentation.video?.should == true
end

