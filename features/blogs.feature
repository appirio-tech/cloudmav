Feature: Blogs

	As a CodeMav user
	I want to sync with my blogs
	So that I can get points and people can see what blog posts I've written
	
	Background:
		Given I am logged in
		And there are guidances
		
    #	Scenario: Add Blog
    #	
    #		When I add a blog
    #		Then the blog should be added to my profile 
    #		And I should be awarded the "iBlog" badge
    #		# And I should have 10 writer points
    #		And I should learned "Adding a blog to your profile"
    #    And I should have posts

  Scenario: Peter adds a blog

    When I add a blog "http://feeds.feedburner.com/pseale"
    Then the blog should be added to my profile
    And I should have posts
		
