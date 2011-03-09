Feature: Follow

  As a user
  I want to follow other users
  So that I can be informed on their activity

  Scenario: Follow another user

    Given I am logged in
    And there is a user "l33t_coder"
    When I follow the user "l33t_coder"
    Then I should be following "l33t_coder"
    And "l33t_coder" should have me as a follower
