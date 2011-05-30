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

