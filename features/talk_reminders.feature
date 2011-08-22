Feature: Talk Reminders

  As a user
  I want to be reminded of my talks
  So I don't forget to prepare

  Scenario: Email reminders 1 week before

    Given there are users with talks
    When it is one week before their talks
    Then they should be reminded of their upcoming talk

