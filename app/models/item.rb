class Item < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  belongs_to :user

  belongs_to :item

end
