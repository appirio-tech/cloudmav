Feature: Speaker Bios

  As a user 
  I want to have a speaker bio
  So that I can submit my bio when submitting talks
  
  Scenario: Add Speaker Bio
  
    Given I am logged in
    When I add a speaker bio
    Then I should have a speaker bio
