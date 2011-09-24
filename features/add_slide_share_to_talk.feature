Feature: Add SlideShare to Talk

  As a user
  I want to link SlideShare to a talk
  So that people can see my slides

  Scenario: Add Talk to SlideShare

    Given I am logged in
    And I have a talk
    When I try to link my talk to SlideShare
    Then I should be able to add my talk to SlideShare

  Scenario: SlideShare talk already added
  
    Given I am logged in
    And I have a talk
    And I have a talk from SlideShare
    When I link the talk to the SlideShare talk
    Then the talk should have my SlideShare info
    And my SlideShare talk should be deleted
  
  Scenario: Added Talk to SlideShare and need to refresh
  
    Given I am logged in
    And I have a talk
    And I added a talk to SlideShare
    When I refresh from the link my talk to SlideShare
    Then I should be able to select the SlideShare talk
