Feature: Tagging

	As a user
	I want to tag things
	So that I can classify items
	
	Scenario: Add new tag
	
		Given I am logged in
		And I have a talk	
		When I tag the talk with "C#"
		Then there should be a "C#" tag
		And the talk should be tagged with "C#"
		
	Scenario: Add existing tag	
	
		Given I am logged in
		And I have a talk	
		And there is a tag "C#"
		When I tag the talk with "C#"
		Then there should be a "C#" tag
		And the talk should be tagged with "C#"