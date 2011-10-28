require 'spec_helper'

describe Blog do

  describe "validation" do
    it "should require a url" do
      
      blog = Factory.build(:blog, :url => nil)
      blog.should_not be_valid
    end

  end

end