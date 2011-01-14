Feature: Jobs
	
	As a user
	I want to manage my jobs
	So that I can tell CodeMav about my work experience
	
	Scenario: Add a new job and new company
	
		Given I am logged in
		When I add a job with "ChaiOne"
		Then the job should be added
		And there should be the company "ChaiOne"