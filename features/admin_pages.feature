Feature: Admin Pages

  As an admin
  I want to view pages
  So that I can check styling
  
  Scenario: Typography
  
    Given I am logged in as an admin
    When I view the admin typography page
    Then I should see all heading types