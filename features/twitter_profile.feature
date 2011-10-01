Feature: TwitterProfile 

	As a user
	I want to sync with my Twitter account
	So that others can see twitter information

  Background:
    Given I am logged in

  Scenario: Sync with account
  	
    When I sync my Twitter account
    Then I should have a Twitter profile
    And I should have followers on twitter
    And it should pull my name from twitter
    And it should pull my location from twitter
    And I should have 10 social points
    And I should be on my edit profile page    

  Scenario: Edit profile
  
    Given I have a Twitter profile
    When I edit my Twitter profile
    Then my Twitter profile should be updated
    And I should be on my edit profile page
  
  Scenario: Don't see Twitter on users without Twitter
  
    Given there is another user
    When I view their social profile
    Then I should not see their Twitter profile
  
  Scenario: See Twitter on users with Twitter
  
    Given there is another user
    And the other user has a Twitter profile
    When I view their social profile
    Then I should see their Twitter profile

  Scenario: Delete Twitter

    Given I have a Twitter profile
    When I delete my Twitter profile
    Then I should not have a Twitter profile
    And I should be on my edit profile page