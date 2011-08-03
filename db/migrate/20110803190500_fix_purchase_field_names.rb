class FixPurchaseFieldNames < ActiveRecord::Migration
  def self.up
    rename_column :purchase, :ry11, :fy11
    rename_column :purchase, :ry12, :fy12
  end

  def self.down
    rename_column :purchase, :fy11, :ry12
    rename_column :purchase, :fy12, :ry12
  end
end
