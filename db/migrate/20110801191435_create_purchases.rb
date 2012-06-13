class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table("purchase", :primary_key => :pid) do |t|
      t.integer :pid
      t.integer :rid
      t.string :os
      t.integer :flexlm
      t.integer :name
      t.integer :fy10
      t.integer :ry11
      t.integer :ry12
      t.integer :fy13

      t.timestamps
    end
  end

  def self.down
    drop_table "purchase"
  end
end
