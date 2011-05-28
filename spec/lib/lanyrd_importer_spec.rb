require 'spec_helper'

describe "Lanyrd Importer" do

  describe "import topic" do
    before(:each) do
      VCR.use_cassette("lanyrd import topic net", :record => :new_episodes) do
        LanyrdImporter.import_from_topic!("net")
      end
    end

    it { BacklogItem.count.should > 0 }
    it { BacklogItem.first.tags.count.should > 0 }
    it { BacklogItem.first.description.should_not be_blank }
    it { BacklogItem.first.start_date.should_not be_nil }
  end

end
