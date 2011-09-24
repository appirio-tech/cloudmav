Feature: Rate a talk

  As a user
  I want to rate a talk
  So that speaker can earn points and get recognized

  Scenario: User does not have a SpeakerRate account

    Given there is a user
    And the user has a talk
    When I am looking at the talk
    Then I should see the user does not have a SpeakerRate account

  Scenario: Talk not added to SpeakerRate
  
    Given there is a user
    And the user has a talk
    And the user has a SpeakerRate profile
    When I am looking at the talk
    Then I should see the user has not added the talk to SpeakerRate yet
  
  Scenario: Talk rateable
  
    Given there is a user
    And the user has a talk
    And the user has a SpeakerRate profile
    And the talk is on SpeakerRate
    When I am looking at the talk
    Then I should be able to rate the talk
