Feature: Jobs
	
	As a user
	I want to manage my jobs
	So that I can tell CodeMav about my work experience
	
	Scenario: Add a new job and new company
	
		Given I am logged in
		When I add a job with "ChaiOne" where I worked on "rails, ruby"
		Then the job should be added
    And there should be the company "ChaiOne"
    And the job should be tagged with "rails, ruby"
    And the company "ChaiOne" should be tagged with "rails, ruby"
    And my experience profile should be tagged with "rails, ruby"
		
    #Scenario: Add a new job with existing company
	
    #Given I am logged in
    #And there is a company "ChaiOne"
    #When I add a job with "ChaiOne"
    #Then the job should be added
    #And there should be the company "ChaiOne"
		
    #Scenario: Edit a job
	
    #Given I am logged in
    #And I have a job
    #When I edit my job
    #Then the job should be updated
	
	
