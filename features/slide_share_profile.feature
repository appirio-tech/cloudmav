Feature: Slide Share Profile 

  As a user
  I want to synch with my Slide Share account
  So that others can see my slides and my talks
  
  Scenario: Synch with account
  
    Given I am logged in
    And there are guidances
    When I synch my SlideShare account
    Then I should have a SlideShare profile
    And I should import my talks from SlideShare
    And I should be awarded the "Sliding along" badge
    And I should have 40 speaker points
    And I should learned "Syncing with your SlideShare Account"
    
  Scenario: Synching again
  
    Given I am logged in
    And there are guidances
    And I have synched my SlideShare account
    When I synch my SlideShare account
    Then I should not have duplicate talks from SlideShare

  Scenario: Don't see SlideShare on users without SlideShare

    Given there is another user
    When I view their speaker profile
    Then I should not see their SlideShare profile

  Scenario: See SlideShare on users with SlideShare

    Given there is another user
    And the other user has a SlideShare profile
    When I view their speaker profile
    Then I should see their SlideShare profile
