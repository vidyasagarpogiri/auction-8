class Bid < ActiveRecord::Base

  validates :user_id, :item_id, presence: true

  has_many :bids

end
