Feature: Edit Profile

	As a user
	I want to edit my profile
	So that I can update my information
	
	Background:
		Given I am logged in
		And I am on my profile page
		When I edit my profile
		
	Scenario: Edit my name
	
		When I change my name to "John"
		Then my name should be updated to "John"
		
	Scenario: Edit my location
	
		When I change my location
		Then my location should be updated
