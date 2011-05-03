Feature: Backlog

  As a user
  I want to use the backlog
  So that I can know whats up

  Scenario: Add to backlog

    Given I am logged in
    When I add an item to the backlog
    Then the item should be on the backlog

  Scenario: Edit backlog 

    Given I am logged in
    And I added a backlog item
    When I update my backlog item
    Then the backlog item should be updated
