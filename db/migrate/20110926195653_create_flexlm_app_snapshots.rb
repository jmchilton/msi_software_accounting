class CreateFlexlmAppSnapshots < ActiveRecord::Migration
  def self.up
    create_table :flexlm_app_snapshots, :name => "flexlm_app_snapshots", :primary_key => :id do |t|
      t.integer :id
      t.datetime :for_date
      t.string :feature
      t.string :vendor
      t.integer :total_licenses
      t.integer :used_licenses

    end
  end

  def self.down
    drop_table :flexlm_app_snapshots
  end
end
