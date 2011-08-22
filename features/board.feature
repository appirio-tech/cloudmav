Feature: Board

  As a user
  I want to view my board
  So I know whats going on

  Scenario: View backlog items

    Given I am logged in
    And there are backlog items
    And there are events
    When I view my board
    Then I should see backlog items
    And I should see an event log
