class CreateFlexlmUserSnapshots < ActiveRecord::Migration
  def self.up
    create_table :flexlm_user_snapshots, :name => "flexlm_user_snapshots", :primary_key => :id do |t|
      t.integer :flexlm_app_snapshot_id
      t.string :username
      t.integer :licenses
      t.datetime :start
      t.string :host

      t.timestamps
    end
  end

  def self.down
    drop_table :flexlm_user_snapshots
  end
end
