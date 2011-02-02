Feature: Technologies

	As a user
	I want to manage technologies
	So that I can associate tags with technologies
	
	Scenario: Add Technology
	
		Given I am logged in
		And I can manage technology
		When I add a technology
		Then the technology should be added

  Scenario: Edit Technology

    Given I am logged in
    And I can manage technology
    And there is a technology
    When I edit a technology
    Then the technology should be updated

  Scenario: Delete Technology

    Given I am logged in
    And I can manage technology
    And there is a technology
    When I delete a technology
    Then the techology should be deleted
