Feature: Companies

	As a user
	I want to view a company's profile
	So that I can see info about the company

	Scenario: View Company Profile

		Given there is a company
		When I view the company
		Then I should see the company's info