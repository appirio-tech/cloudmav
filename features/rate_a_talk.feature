Feature: Rate a talk

  As a user
  I want to rate a talk
  So that speaker can earn points and get recognized

  Scenario: User does not have a speaker rate account

    Given there is a user
    And the user has a talk
    When I am looking at the talk
    Then I should see the user does not have a speaker rate account

  Scenario: Talk not added to speaker rate

    Given there is a user
    And the user has a talk
    And the user has a speaker rate profile
    When I am looking at the talk
    Then I should see the user has not added the talk to speaker rate yet

  Scenario: Talk rateable

    Given there is a user
    And the user has a talk
    And the user has a speaker rate profile
    And the talk is on speaker rate
    When I am looking at the talk
    Then I should be able to rate the talk
