Feature: Speaker Rate Profile 

	As a user
	I want to sync with my SpeakerRate account
	So that others can see my rating and my talks
	
	Scenario: Sync with account
	
		Given I am logged in
		And there are guidances
		When I sync my SpeakerRate account
		Then I should have a SpeakerRate profile
    And my SpeakerRate profile should be synced
		And I should have my talks from SpeakerRate
		And I should be awarded the "I need validation" badge
		And I should have 30 speaker points
		And I should learned "Syncing with your SpeakerRate Account"
		
	Scenario: Sync again
	
		Given I am logged in
		And there are guidances
		And I synced my SpeakerRate account
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
