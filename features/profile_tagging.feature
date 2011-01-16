Feature: Profile Tagging

	As a user
	I want my profile to be tagged
	So that people know my skillset
	
	Scenario: Tagging from Talks
	
		Given I have a profile
		And I have a talk tagged with "C#"
		When my profile's tags are calculated
		Then my profile should have a "C#" tag
		
	Scenario: Tagging from StackOverflow
	
		Given I have a profile
		And I have a stackoverflow profile tagged with "WPF"
		When my profile's tags are calculated
		Then my profile should have a "WPF" tag