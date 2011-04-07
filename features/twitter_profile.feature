Feature: TwitterProfile 

	As a user
	I want to synch with my Twitter account
	So that others can see twitter information

  Background:
    Given I am logged in
		And there are guidances

  Scenario: Synch with account
  	
    When I synch my Twitter account
    Then I should have a Twitter profile
    And I should have followers on twitter
    And it should pull my name from twitter
    And it should pull my location from twitter
    And I should have 10 social points
    And I should learned "Synching your Twitter Account"

  Scenario: Edit profile

    Given I have a Twitter profile
    When I edit my Twitter profile
    Then my Twitter profile should be updated

