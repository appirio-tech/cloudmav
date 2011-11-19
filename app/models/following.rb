class Following
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::HasSubject

  belongs_to :followable, :polymorphic => true
end
