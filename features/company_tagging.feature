Feature: Company Tagging
	
	As a user
	I want companies to be tagged
	So that I can see a company's profile
	
	Scenario: One employee
	
		Given there is a company
		And there is an employee with a job tagged "iPhone"
		When the company's tags are calculated
		Then the company should be tagged "iPhone"
		
	Scenario: Two employees
	
		Given there is a company
		And there is an employee with a job tagged "iPhone"
		And there is an employee with a job tagged "Rails"
		When the company's tags are calculated
		Then the company should be tagged "iPhone"
		And the company should be tagged "Rails"
		
	Scenario: Two employees with same tag
	
		Given there is a company
		And there is an employee with a job tagged "iPhone"
		And there is an employee with a job tagged "iPhone"
		When the company's tags are calculated
		Then the company should be tagged "iPhone"
		And the company tag "iPhone" should have a count of 2
		And the company tag "iPhone"	should have a weighted score of 2