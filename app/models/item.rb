class Item < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  belongs_to :user

  belongs_to :item

  def max_bid
    Bid.where(item_id: self.id).maximum(:amount)
  end

end
