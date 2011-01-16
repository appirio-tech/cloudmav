Feature: Company Tagging
	
	As a user
	I want companies to be tagged
	So that I can see a company's profile
	
	Scenario: One employee
	
		Given there is a company
		And there is an employee tagged "iPhone"
		When the company's tags are calculated
		Then the company should be tagged "iPhone"