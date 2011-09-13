Feature: Add Slide Share to Talk

  As a user
  I want to link slide share to a talk
  So that people can see my slides

  Scenario: Add Talk to Slide Share

    Given I am logged in
    And I have a talk
    When I try to link my talk to Slide Share
    Then I should be able to add my talk to Slide Share

  Scenario: Slide Share talk already added
  
    Given I am logged in
    And I have a talk
    And I have a talk from Slide Share
    When I link the talk to the Slide Share talk
    Then the talk should have my Slide Share info
    And my Slide Share talk should be deleted
  
  Scenario: Added Talk to Slide Share and need to refresh
  
    Given I am logged in
    And I have a talk
    And I added a talk to Slide Share
    When I refresh from the link my talk to Slide Share
    Then I should be able to select the Slide Share talk
