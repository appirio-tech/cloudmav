class Knowledge
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :guidance
end