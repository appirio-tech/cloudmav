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

  Scenario: Friend another user

    Given I am logged in
    And there is a user "l33t_coder"
    And user "l33t_coder" is following me
    When I follow the user "l33t_coder"
    Then "l33t_coder" should be my friend
    And I should see "l33t_coder" on my social page
  
  Scenario: Unfollow another user from their profile page

    Given I am logged in
    And there is a user "l33t_coder"
    And I follow the user "l33t_coder"
    When I unfollow "l33t_coder" from their profile page
    Then I should not be following "l33t_coder"
