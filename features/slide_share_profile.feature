Feature: Slide Share Profile 

	As a user
	I want to synch with my Slide Share account
	So that others can see my slides and my talks
	
	Scenario: Sync with account
	
		Given I am logged in
		And there are guidances
		When I synch my SlideShare account
		Then I should have a SlideShare profile
		And I should be awarded the "Sliding along" badge
		# And I should have 10 speaker points
		And I should learned "Syncing with your SlideShare Account"