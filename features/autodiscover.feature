Feature: Autodiscover

  As a user
  I want my accounts to be autodiscovered
  So that I don't have to enter the information by hand

  Scenario: Autodiscover

    Given I just signed up
    When I am autodiscovered
    Then my GitHub account should be autodiscovered
    And my Bitbucket account should be autodiscovered
