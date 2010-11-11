Feature: People Search

	As a user
	I want to search for people
	So that I can find colleagues and lookup their information
	
	
	Scenario: Search for people near a location
	
		Given "Joe" is located at "Houston, TX"
		And "Bob" is located at "Dallas, TX"
		When I search for people near "Houston, TX"
		Then I should see "Joe"