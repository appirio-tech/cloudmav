Feature: Tags

	As a user
	I want to manage tags
	So that I can moderate the tags in the system
	
	Background:
		Given I am logged in
		And I can manage tags
			
	Scenario: Add a tag
		When I add the tag "WPF"
		Then there should be a tag "WPF"
		
	Scenario: Edit a tags synonyms
		Given there is a tag "WPF"
		When I change the tag "WPF"'s synonyms to "Windows Presentation Foundation"
		Then there should be a tag "WPF"
		And the tag "WPF"'s synonyms should be "WPF, Windows Presentation Foundation"