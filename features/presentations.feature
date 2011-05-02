Feature: Presentations

  As a user 
  I want to input presentations
  So that I can share when I am giving talks

  Scenario: Schedule a new presentation

    Given I am logged in
    And I have a talk
    When I schedule a presentation
    Then the presentation should be added

  Scenario: Edit a presentation

    Given I am logged in
    And I have a talk
    And the talk has a presentation
    When I edit the presentation
    Then the presentation should be edited
