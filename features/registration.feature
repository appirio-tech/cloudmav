Feature: Registration

	As a visitor
	I want to register with this site
	So that I can use CodeMav
		
	Scenario: Register new user
	
		Given I am a visitor
		When I go to the registration page
		And I register with my information
		Then I should be registered
		And I should have a profile
		And my profile email should be my user email
    And I should be redirected to my syncable page

