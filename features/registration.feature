Feature: Registration

	As a visitor
	I want to register with this site
	So that I can use CodeMav
		
	Scenario: Register new user
	
		Given I am a visitor
		When I go to the registration page
		And I register with my information
		Then I should be registered
		And I should have a profile
		And my profile email should be my user email
    And I should be redirected to the autodiscover page

  Scenario: Register from homepage

    Given I am a visitor
    When I register from the home page
    Then I should be registered

  Scenario: Bad registration from homepage

    Given I am a visitor
    When I register with bad info on the home page
    Then I should not be registered