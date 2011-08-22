Feature: Follow

  As a user
  I want to follow other users
  So that I can be informed on their activity

  Scenario: Follow another user

    Given I am logged in
    And there is a user "l33tcoder"
    When I follow the user "l33tcoder"
    Then I should be following "l33tcoder"
    And "l33tcoder" should have me as a follower

  Scenario: Follow same user

    Given I am logged in
    And there is a user "l33tcoder"
    When I follow the user "l33tcoder"
    Then I should be following "l33tcoder"
    And "l33tcoder" should have me as a follower
    And there should not be a duplicate following of "l33tcoder"

  Scenario: Friend another user

    Given I am logged in
    And there is a user "l33tcoder"
    And user "l33tcoder" is following me
    When I follow the user "l33tcoder"
    Then "l33tcoder" should be my friend
    And I should see "l33tcoder" on my social page
  
  Scenario: Unfollow another user from their profile page

    Given I am logged in
    And there is a user "l33tcoder"
    And I follow the user "l33tcoder"
    When I unfollow "l33tcoder" from their profile page
    Then I should not be following "l33tcoder"
