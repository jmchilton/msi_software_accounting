class CreateExecutables < ActiveRecord::Migration
  def self.up
    create_table("executable", :primary_key => "exid") do |t|
      t.integer :exid
      t.integer :identifier_type
      t.string :identifier
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table "executable"
  end
end
