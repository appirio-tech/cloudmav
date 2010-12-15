Feature: Projects

	As a user
	I want to add projects
	So that my experience can be shared
	
	Scenario: Add project
	
		Given I am logged in
		When I add a project
		Then the project should be added
	