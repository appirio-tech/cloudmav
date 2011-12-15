Feature: Point summary

  As a user
  I want to see my point summary
  So that I can I see how I earned my points
  
  Scenario: Point Summary
  
    Given I am logged in
    And I have earned speaker points
    When I view my point summary
    Then I should see how I earned my speaker points