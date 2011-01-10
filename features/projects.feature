Feature: Projects

	As a user
	I want to add projects
	So that my experience can be shared
	
	Background:
		Given I am logged in
		
	Scenario: Add project
	
		When I enter my project information
		And I add the project
		Then the project should be added
		
	Scenario: Add project with new technologies
	
		When I enter my project information
		And I enter the technologies "ruby, C#"
		And I add the project
		Then the project should be added
		And technology "Ruby" should be added
		And technology "C#" should be added
		And I should have experience in "Ruby"
		And I should have experience in "C#"
	
	Scenario: Project with end date before start date
	
		When I enter my project information
		And I enter the start date as "12/10/2010"
		And I enter the end date as "12/3/2010"
		And I add the project
		Then the project should not be added
		And I should get the error message "Start date must be before end date"
		And I should get the error message "End date must be after start date"
		
	Scenario: Project with same start and end date

		When I enter my project information
		And I enter the start date as "12/10/2010"
		And I enter the end date as "12/10/2010"
		And I enter the technologies "C#"
		And I add the project
		Then the project should be added
		And the experience with "C#" should have a duration