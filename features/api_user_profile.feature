Feature: API User Profile

	As a developer
	I want to use the CodeMav API to get user profile data
	So I can use it in a mobile app
	
	Scenario: Get User Profile
	  Given there is a user "skywalker10"
		When I send a GET request to "api/v1/profiles/skywalker10.json"
		Then the response should be "200"
		And the response should have "skywalker10"'s profile data
