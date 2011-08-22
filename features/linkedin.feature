Feature: LinkedIn

  As a user 
  I want to sync with LinkedIn
  So my profile can have my previous jobs

  Background:
    Given I am logged in
    And there are guidances

  Scenario: Delete LinkedIn

    Given I have a LinkedIn profile
    And I have jobs
    When I delete my LinkedIn profile
    Then I should not have a LinkedIn profile
    And I should not have any jobs
    And I should not have any job events
