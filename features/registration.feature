Feature: Registration

	As a visitor
	I want to register with this site
	So that I can use codemav
		
	Scenario: Register new user
	
		Given I am a visitor
		When I go to the registration page
		And I register with my information
		Then I should be registered
		And I should have a profile