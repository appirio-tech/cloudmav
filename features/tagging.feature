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
		
	Scenario: Remove tag
		
		Given I am logged in
		And I have a talk
		And there is a tag "C#"
		And there is a tag "LINQ"
		And the talk is tagged "C#, LINQ"
		When I tag the talk with "LINQ"
		Then the talk should be tagged with "LINQ"
		And the talk should not be tagged with "C#"
		
	Scenario: Clear tags
	
		Given I am logged in
		And I have a talk
		And there is a tag "C#"
		And there is a tag "LINQ"
		And the talk is tagged "C#, LINQ"
		When I tag the talk with ""
		Then the talk should not be tagged with "LINQ"
		And the talk should not be tagged with "C#"
		
	Scenario: Synonym
	
		Given I am logged in
		And I have a talk
		And there is a tag "C#" with synonyms "c_sharp"
		When I tag the talk with "c_sharp"
		Then the talk should be tagged with "C#"
		And there should not be a tag "c_sharp"