Feature: Recalculate Points

  As a user
  I want my score recalculate
  So that my score reflects the correct point value

  Scenario: No point changes

    Given I have an account
    And I have earned some points
    When my score is recalculated
    Then my score should be the same
