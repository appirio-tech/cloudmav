Feature: Talk with Video

  As a user
  I want to add a video to my talk
  So users can watch my talk

  Scenario: Add video to talk

    Given I am logged in
    When I add a video to a talk
    Then the video should be added to the talk
