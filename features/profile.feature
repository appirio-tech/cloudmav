Feature: Profile

  As a user
  I want to view my profile
  So that I can manage my CodeMav information
  
  Scenario: View Profile
  
    Given I am logged in
    When I view my profile
    Then I should be able to view the menu