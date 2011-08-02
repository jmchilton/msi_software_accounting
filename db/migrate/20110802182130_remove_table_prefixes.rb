class RemoveTablePrefixes < ActiveRecord::Migration
  def self.up
    rename_table "people.persons", :persons
    rename_table "people.departments", :departments
    rename_table "swacct.event", :event
    rename_table "swacct.executable", :executable
    rename_table "people.groups", :groups
    rename_table "swacct.purchase", :purchase
    rename_table "swacct.resources", :resources
    rename_table "people.users", :users
    rename_table "people.colleges", :colleges
  end

  def self.down
    rename_table :persons, "people.persons"
    rename_table :departments, "people.departments"
    rename_table :event, "swacct.event"
    rename_table :executable, "swacct.executable"
    rename_table :groups, "people.groups"
    rename_table :purchase, "swacct.purchase"
    rename_table :resources, "swacct.resources"
    rename_table :users, "people.users"
    rename_table :colleges, "people.colleges"
  end
end
