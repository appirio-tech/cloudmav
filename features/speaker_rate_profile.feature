Feature: Speaker Rate Profile 

	As a user
	I want to synch with my SpeakerRate account
	So that others can see my rating and my talks
	
	Scenario: Synch with account
	
		Given I am logged in
		And there are guidances
		When I synch my SpeakerRate account
		Then I should have a SpeakerRate profile
		# And I should be awarded the "Stack Junkie" badge
		# And I should have 10 coder points
		# And I should learned "Synching with your Stackoverflow Account"