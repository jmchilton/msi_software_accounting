class FixResourcesPrimaryKey < ActiveRecord::Migration
  def self.up
    drop_table :resources

    create_table "resources", :primary_key => :id do |t|
      t.string   "name"
      t.string   "short_name"
      t.string   "description"
      t.string   "calendar_desc"
      t.string   "documentation"
      t.string   "module"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table "resources"

    create_table :resources, :id => false do |t|
      t.integer  "id"   
      t.string   "name"
      t.string   "short_name"
      t.string   "description"
      t.string   "calendar_desc"
      t.string   "documentation"
      t.string   "module"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "rid"
    end
  end
end
