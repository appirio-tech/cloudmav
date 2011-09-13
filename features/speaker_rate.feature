Feature: Speaker Rate Profile 

	As a user
	I want to sync with my SpeakerRate account
	So that others can see my rating and my talks

  Background:
    Given I am logged in
	
	Scenario: Sync with account
	
		When I sync my SpeakerRate account
		Then I should have a SpeakerRate profile
    And my SpeakerRate profile should be synced
		And I should have my talks from SpeakerRate
    And my talks should have their SpeakerRate info
		And I should be awarded the "I need validation" badge
		And I should have speaker points for SpeakerRate
		
  Scenario: Sync again
  
    Given I synced my SpeakerRate account
    When I sync my SpeakerRate account
    Then I should not have duplicate talks from SpeakerRate
  
  Scenario: Don't see SpeakerRate on users without SpeakerRate

    Given there is another user
    When I view their speaker profile
    Then I should not see their SpeakerRate profile

  Scenario: See SpeakerRate on users with SpeakerRate

    Given there is another user
    And the other user has a SpeakerRate profile
    When I view their speaker profile
    Then I should see their SpeakerRate profile

  Scenario: Edit SpeakerRate

    Given I have a SpeakerRate profile
    When I edit my SpeakerRate id
    Then I should have a SpeakerRate profile
    And my talks should not have their SpeakerRate info
    And I should have my new talks

  Scenario: Delete SpeakerRate

    Given I have a SpeakerRate profile
    When I delete my SpeakerRate profile
    Then I should not have a SpeakerRate profile
    And I should not have the "I need validation" badge
