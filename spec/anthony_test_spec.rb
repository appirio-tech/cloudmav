SCREEN_WIDTH = 100

def last_index_for_row(index, tags)
  last_tag_index = index + 1
  row_distance = tags[index][:width]
  while(row_distance < SCREEN_WIDTH && last_tag_index < tags.count)
    row_distance += tags[last_tag_index][:width]
    last_tag_index += 1
  end
  
  if (last_tag_index < tags.count)
    return last_tag_index - 2
  else
    return last_tag_index - 1
  end
end

describe "Genre tagging" do
  before(:each) do
    @tags = [{ :title => "A", :width => 50 }, 
      { :title => "B", :width => 40 }, 
      { :title => "C", :width => 30 },
      { :title => "D", :width => 30 }]
  end
  
  it "should return B's index" do
    last_index_for_row(0, @tags).should == 1
  end
  it "should return D's index" do
    last_index_for_row(2, @tags).should == 3
  end
end