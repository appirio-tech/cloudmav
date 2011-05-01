Feature: Presentation with Video

  As a user
  I want to add a video to my presentation
  So users can watch my presentation

  Scenario: Add video to presentation

    Given I am logged in
    And I have a talk
    When I add a video to a presentation
    Then the video should be added to the presentation
