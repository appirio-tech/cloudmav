Feature: Talks
	
	As a user
	I want to add talks to CodeMav
	So others can know what I present
	
	Scenario: Add a talk
	
		Given I am logged in
		When I add a talk
		Then the talk should be added