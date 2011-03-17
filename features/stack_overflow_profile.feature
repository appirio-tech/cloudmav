Feature: StackOverflowProfile 

	As a user
	I want to synch with my StackOverflow account
	So that others can see my reputation

  Background:
    Given I am logged in
		And there are guidances
	
	Scenario: Synch with account
	
    When I synch my StackOverflow account
		Then I should have a StackOverflow profile
		And I should be awarded the "Stack Junkie" badge
		And I should have 10 coder points
		And I should learned "Synching with your Stackoverflow Account"
    And my StackOverflow profile should be tagged
    And my profile should have my StackOverflow profile tags

  Scenario: Edit profile

    Given I have a StackOverflow profile
    When I edit my StackOverflow profile
    Then my StackOverflow profile should be updated
