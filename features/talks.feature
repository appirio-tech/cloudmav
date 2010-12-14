Feature: Talks
	
	As a user
	I want to add talks to CodeMav
	So others can know what I present
	
	Scenario: Add a talk
	
		Given I am logged in
		When I add a talk
		Then the talk should be added
		
	Scenario: Add a presentation
	
		Given I am logged in
		And I have a talk
		When I add a presentation for that talk
		Then the presentation should be added