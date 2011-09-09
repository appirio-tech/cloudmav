module SunspotAdapters
  class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
    def id
      @instance.id
    end
  end

  class DataAccessor < Sunspot::Adapters::DataAccessor
    def load(id)
      @clazz.find(id)
    end
  end    
end

[Talk, Profile, Company, BacklogItem].each do |klass|
  Sunspot::Adapters::InstanceAdapter.register(SunspotAdapters::InstanceAdapter, klass)
  Sunspot::Adapters::DataAccessor.register(SunspotAdapters::DataAccessor, klass)
end
