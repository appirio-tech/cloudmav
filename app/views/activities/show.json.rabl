collection @activity => :activities

code(:title) { |a| a[:title] }
code(:date) { |a| a[:date].strftime("%b %d, %Y") }
