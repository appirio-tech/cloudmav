Feature: Tag Job

  As a user 
  I want to tag my job
  So that I can get skill points
  
  Scenario: Tag Job
  
    Given I am logged in
    And I have a job from "1/1/2010" thru "12/1/2010"
    And there is a skill "ruby" for tags "ruby"    
    When I tag the job with "ruby"
    Then the job should be tagged with "ruby"
    Then the job should have "ruby" experience points