class AddModuleRelatedModels < ActiveRecord::Migration
  def self.up
    create_table :modules, :name => "modules", :primary_key => :id do |t|
      t.integer :id
      t.string :name
    end

    create_table :module_loads, :name => "module_loads", :primary_key => :id do |t|
      t.integer :id
      t.string :name
      t.datetime :date
      t.string :username
      t.string :version
      t.string :hostname
    end


  end

  def self.down
    drop_table :modules
    drop_table :module_loads
  end

end
