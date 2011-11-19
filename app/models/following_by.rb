class FollowingBy
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::HasSubject

  belongs_to :following_by_able, :polymorphic => true
end
