Feature: User Groups

	As a user
	I want to manage user groups
	So that others know what is going on around town
	
	Scenario: Add User Group
	
		Given I am logged in
		When I add a user group "Houston C#"
		Then the user group should be added
		And I should be on the "Houston C#" user group page