Feature: SlideShare Profile 

  As a user
  I want to sync with my SlideShare account
  So that others can see my slides and my talks

  Background:
    Given I am logged in
  
  Scenario: Sync with account
  
    When I sync my SlideShare account
    Then I should have a SlideShare profile
    And I should import my talks from SlideShare
    And my talks should have their SlideShare info
    And I should be awarded the "Sliding along" badge
    And I should have speaker points
    And I should have a slide count on my SlideShare profile
    And my SlideShare profile should have the url
    And I should be on my edit profile page    
    
  Scenario: 
    When I sync my SlideShare account with username "arisbartee"
    Then I should have a SlideShare profile
    And my SlideShare profile should have the url    
    
  Scenario: Sync with account that has only 1 slide
  
    When I sync my SlideShare account that has only 1 slide
    Then I should have a SlideShare profile
    And I should import my talks from SlideShare
  
  # Scenario: Syncing again
  # 
  #   Given I have synced my SlideShare account
  #   When I sync my SlideShare account
  #   Then I should not have duplicate talks from SlideShare
  # 
  # Scenario: Show Talk
  # 
  #   Given there is another user
  #   And the other user has a SlideShare profile
  #   When I look at their talk from SlideShare
  #   Then I should be able to download the slides
  #   And I should see a slideshow
  # 
  Scenario: Don't see SlideShare on users without SlideShare
  
    Given there is another user
    When I view their profile
    Then I should not see their SlideShare profile
  
  Scenario: See SlideShare on users with SlideShare
  
    Given there is another user
    And the other user has a SlideShare profile
    When I view their profile
    Then I should see their SlideShare profile
  
  
  Scenario: Edit SlideShare
  
    Given I have a SlideShare profile
    When I edit my SlideShare username
    Then I should have a SlideShare profile
    And my old talks should be not have their SlideShare info
    And I should have my new talks
    And I should be on my edit profile page
      
  Scenario: Delete SlideShare
  
    Given I have a SlideShare profile
    When I delete my SlideShare profile
    Then I should not have a SlideShare profile
    And my old talks should be not have their SlideShare info
    And I should not have the "Sliding along" badge
    And I should be on my edit profile page
    
  Scenario: SlideShare Error

    Given I have a SlideShare profile
    When I there is an error with my SlideShare sync
    Then I should see my SlideShare error on my syncable page    