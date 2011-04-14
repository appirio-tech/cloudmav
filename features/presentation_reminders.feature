Feature: Presentation Reminders

  As a user
  I want to be reminded of my presentations
  So I don't forget to prepare

  Scenario: Email reminders 1 week before

    Given there are users with presentations
    When it is one week before there presentation
    Then they should be reminded of their upcoming presentation

