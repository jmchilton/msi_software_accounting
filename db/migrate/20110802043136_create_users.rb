class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table("users", :primary_key => :id )do |t|
      t.integer :id
      t.string :username

      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end
