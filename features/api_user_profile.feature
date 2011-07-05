Feature: API User Profile

	As a developer
	I want to use the CodeMav API to get user profile data
	So I can use it in a mobile app
	
	Scenario: Get Profile
	  Given there is a user "skywalker10"
		When I send a GET request to "api/v1/profiles/skywalker10.json"
		Then the response should be "200"
		And the response should have "skywalker10"'s profile data

  Scenario: Get Profile Tags
    Given there is a user "skywalker10"
    And "skywalker10" has a tag "ruby" with a score of "10"
    And "skywalker10" has a tag "python" with a score of "1"
		When I send a GET request to "api/v1/profiles/skywalker10/tags.json"
		Then the response should be "200"
    And the response should have the "ruby" tag with a score of "10"
    And the response should have the "python" tag with a score of "1"
