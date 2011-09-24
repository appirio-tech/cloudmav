Feature: See Slides for a Talk

  As a user
  I want to see the slides for a talk
  So that I can look learn information

  Scenario: User does not have a SlideShare account

    Given there is a user
    And the user has a talk
    When I am looking at the talk
    Then I should see the user does not have a SlideShare account

  Scenario: Talk not added to SlideShare
  
    Given there is a user
    And the user has a talk
    And the user has a SlideShare profile
    When I am looking at the talk
    Then I should see the user has not added the slides to SlideShare yet
  
  Scenario: Talk has slides
  
    Given there is a user
    And the user has a talk
    And the user has a SlideShare profile
    And the talk is on SlideShare
    When I am looking at the talk
    Then I should be able to view the slides
