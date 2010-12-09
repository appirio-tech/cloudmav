Feature: StackOverflowProfile 

	As a user
	I want to synch with my StackOverflow account
	So that others can see my reputation
	
	Scenario: Synch with account
	
		Given I am logged in
		And there are guidances
		When I synch my StackOverflow account
		Then I should have a StackOverflow profile
		And I should be awarded the "Stack Junkie" badge
		And I should have 10 coder points
		And I should learned "Synching with your Stackoverflow Account"