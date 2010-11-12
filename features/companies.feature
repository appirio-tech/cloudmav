Feature: Companies

	As a user
	I want to manage companies 
	So that I can relate my work history and find colleagues
	
	Scenario: Add Company
	
		Given I am logged in
		When I add a company
		Then the company should be added
		And I should be on the company page