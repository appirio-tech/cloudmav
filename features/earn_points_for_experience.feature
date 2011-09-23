Feature: Earn points for experience

  As a user
  I want to earn points for my experience
  So that I can get recognition for my years of work
  
  Scenario: 1 job
  
    Given I am a user
    And I have a job "Lead Developer" from "8/1/2010" to "9/1/2010"
    When my profile is scored
    Then I should have experience points for my jobs
    