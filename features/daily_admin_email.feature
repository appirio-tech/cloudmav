Feature: Daily Admin Email

  As an admin
  I want a daily email about the system
  So that I know what happened the day before

  Scenario: Daily Admin Email

    Given there are 100 users
    And there is a new user "jsmith"
    When the daily admin email is sent
    Then the email should show 101 total users
    And the email should have "jsmith" as a new user
