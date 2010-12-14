
badge "Stack Junkie" do
  thing StackOverflowProfile
  subject :profile
  conditions do |so|
    !so.profile.nil?
  end
end

badge "Git r Done" do
  thing GitHubProfile
  subject :profile
  conditions do |git|
    !git.profile.nil?
  end
end

badge "iBlog" do
  thing Blog
  subject :profile
end

badge "I need validation" do
  thing SpeakerRateProfile
  subject :profile
end