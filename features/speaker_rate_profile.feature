Feature: Speaker Rate Profile 

	As a user
	I want to synch with my SpeakerRate account
	So that others can see my rating and my talks
	
	Scenario: Synch with account
	
		Given I am logged in
		And there are guidances
		When I synch my SpeakerRate account
		Then I should have a SpeakerRate profile
		And I should have my talks from SpeakerRate
		And I should be awarded the "I need validation" badge
		And I should have 40 speaker points
		And I should learned "Syncing with your SpeakerRate Account"
		
	Scenario: Synch again
	
		Given I am logged in
		And there are guidances
		And I synched my SpeakerRate account
		When I synch my SpeakerRate account
		Then I should not have duplicate talks from SpeakerRate