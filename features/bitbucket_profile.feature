Feature: BitbucketProfile 

  As a user
  I want to sync with my Bitbucket account
  So that others can see source and followers
  
  Scenario: Sync with account
  
    Given I am logged in
    And there are guidances
    When I sync my Bitbucket account
    Then I should have a Bitbucket profile
    And I should have the collection of my Bitbucket repos
    And I should be awarded the "Bucketeer" badge
    And I should have 10 coder points
    And I should learned "Syncing with your Bitbucket Account"

  Scenario: Don't see Bitbucket on users without Bitbucket

   Given there is another user
   When I view their code profile
   Then I should not see their Bitbucket profile

  Scenario: See Bitbucket on users with Bitbucket

   Given there is another user
   And the other user has a Bitbucket profile
   When I view their code profile
   Then I should see their Bitbucket profile

  Scenario: Edit Bitbucket

    Given I am logged in
    And there are guidances
    And I have a Bitbucket profile
    When I edit my Bitbucket id
    Then I should have a Bitbucket profile
    And my old Bitbucket events should be deleted
    And my old repositories should be deleted
    And I should have my new repositories

  Scenario: Delete Bitbucket

    Given I am logged in
    And there are guidances
    And I have a Bitbucket profile
    When I delete my Bitbucket profile
    Then I should not have a Bitbucket profile
    And I should not have the "Bucketeer" badge
    And my old Bitbucket events should be deleted
    And my old repositories should be deleted
    And I should have 0 coder points

