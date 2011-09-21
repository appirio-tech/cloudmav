Feature: Link code repo to talk

  As a user
  I want to link a code repo to a talk
  So that visitors can get the code for my talk
  
  Scenario: GitHub Repo
  
    Given I am logged in
    And I have a GitHub repo
    And I have a talk
    When I link my GitHub repo to my talk
    Then the talk should have my GitHub repo
    And I should see the GitHub repo when I look at my talk
    
  Scenario: Bitbucket Repo
  
    Given I am logged in
    And I have a Bitbucket repo
    And I have a talk
    When I link my Bitbucket repo to my talk
    Then the talk should have my Bitbucket repo
    And I should see the Bitbucket repo when I look at my talk  