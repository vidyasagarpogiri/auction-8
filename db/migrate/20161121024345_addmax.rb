class Addmax < ActiveRecord::Migration
  def change
    add_index :bids, :amount
  end
end
