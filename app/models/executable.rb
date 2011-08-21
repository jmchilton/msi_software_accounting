class Executable < ActiveRecord::Base
  set_table_name "executable"
  set_primary_key "exid"

  belongs_to :resource, :foreign_key => "rid"
  has_many :events, :foreign_key => "feature", :primary_key => "identifier"

  def self.flexlm_report_for_resource(resource_id, from = nil, to = nil)
    select("executable.exid, executable.exid as id, executable.identifier, #{Event.demographics_summary_selects}").
      joins(Event.to_demographics_joins(from, to)).
      where("executable.rid = ?", resource_id).
      group("executable.exid")
  end

end
