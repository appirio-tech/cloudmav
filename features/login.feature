Feature: Login

	As a user
	I want to login
	So that I can access my profile
	
	Scenario: Login
	
		Given I have an account
		When I go to the login page
		And I login
		Then I should be logged in