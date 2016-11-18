class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :current_bid, default: 0
      t.timestamps null: false
    end
    add_index :items, :name, unique: true
  end
end
