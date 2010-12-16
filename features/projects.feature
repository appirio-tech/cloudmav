Feature: Projects

	As a user
	I want to add projects
	So that my experience can be shared
	
	Background:
		Given I am logged in
		
	Scenario: Add project
	
		When I add a project
		Then the project should be added
		
	Scenario: Add project with new technologies
	
		When I add a project with technologies "ruby, C#"
		Then the project should be added
		And technology "Ruby" should be added
		And technology "C#" should be added

	