
badge "Stack Junkie" do
  thing StackOverflowProfile
  subject :profile do |so|
    so.profile
  end
  conditions do |so|
    !so.profile.nil?
  end
end