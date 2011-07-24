Feature: Daily Admin Email

  As an admin
  I want a daily email about the system
  So that I know what happened the day before

  Scenario: Daily Admin Email

    Given there are 100 users
    When the daily admin email is sent
    Then the email should show 100 total users
