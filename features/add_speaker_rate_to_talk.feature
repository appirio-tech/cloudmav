Feature: Add SpeakerRate to Talk

  As a user
  I want to link SpeakerRate to a talk
  So that people can rate my talk

  Scenario: Add Talk to SpeakerRate

    Given I am logged in
    And I have a talk
    When I try to link my talk to SpeakerRate
    Then I should be able to add my talk to SpeakerRate

  Scenario: SpeakerRate talk already added
  
    Given I am logged in
    And I have a talk
    And I have a talk from SpeakerRate
    When I link the talk to the SpeakerRate talk
    Then the talk should have my SpeakerRate info
    And my SpeakerRate talk should be deleted
  
  Scenario: Added Talk to SpeakerRate and need to refresh
  
    Given I am logged in
    And I have a talk
    And I added a talk to SpeakerRate
    When I refresh from the link my talk to SpeakerRate
    Then I should be able to select the SpeakerRate talk
   
