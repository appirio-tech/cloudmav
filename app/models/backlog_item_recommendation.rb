class BacklogItemRecommendation
  include Mongoid::Document
  include Mongoid::Timestamps
  extend ActiveSupport::Memoizable

  field :score, :type => Float, :default => 0.0
  field :backlog_item_id

  embedded_in :profile

  def backlog_item
    BacklogItem.find(self.backlog_item_id)
  end
  memoize :backlog_item
end
