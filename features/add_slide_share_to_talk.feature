Feature: Add Slide Share to Talk

  As a user
  I want to link slide share to a talk
  So that people can see my slides

  Scenario: Add Talk to Slide Share

    Given I am logged in
    And I have a talk
    When I try to link my talk to Slide Share
    Then I should be able to add my talk to Slide Share

