Feature: Blogs

	As a CodeMav user
	I want to sync with my blogs
	So that I can get points and people can see what blog posts I've written
	
	
	Scenario: Add Blog
	
		Given I am logged in
		When I add a blog
		Then the blog should be added to my profile 