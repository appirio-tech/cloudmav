Given /^there are users with StackOverflow profiles$/ do
  (1..100).to_a.each do |i|
    user = Factory.create(:user)
    user.profile.stack_overflow_profile = StackOverflowProfile.new(:reputation => 10 * i)
    user.profile.save!
    # , :reputation => 10 * i)
    # puts "profile is #{so.profile.stack_overflow_profile.inspect}"
  end
# puts "count #{Profile.count}"
  # Profile.all.each{|p| puts "profile? #{p.stack_overflow_profile.inspect}"}
end

Then /^I should see the top (\d+) users$/ do |number|
  profiles = Profile.all.to_a.reverse {|x,y| x.stack_overflow_profile.reputation <=> y.stack_overflow_profile.reputation }
  # Profile.all.each{|p| puts "profile #{p.inspect}"}
  # puts "profiles #{profiles.collect{|p| p.stack_overflow_profile.reputation }.inspect}"
  profiles = profiles.first(number.to_i - 1)
  profiles.each do |p|
    And %Q{I should see "#{p.name}"}
    And %Q{I should see "#{p.stack_overflow_profile.reputation}"}
  end
end
