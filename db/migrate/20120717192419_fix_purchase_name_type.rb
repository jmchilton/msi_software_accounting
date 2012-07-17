class FixPurchaseNameType < ActiveRecord::Migration
  def self.up
    change_table :purchase do |t|
      t.change :name, :string
    end
  end

  def self.down
    change_table :purchase do |t|
      t.change :name, :int
    end
  end
end
