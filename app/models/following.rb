class Following
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::HasSubject

end
