Feature: Search Talks

  As a visitor
  I want to search talks
  So that I can find speakers and interesting talk topics
  
  Scenario: Search Talks
  
    Given I am a visitor
    And there are talks
    When I search talks
    Then I should see my talk search results