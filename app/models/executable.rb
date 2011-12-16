class Executable < ActiveRecord::Base
  set_table_name "executable"
  set_primary_key "exid"

  belongs_to :resource, :foreign_key => "rid"
  has_many :events, :foreign_key => "feature", :primary_key => "identifier"

  def self.flexlm_report_for_resource(resource_id, report_options = {})
    select("executable.exid, executable.exid as id, executable.identifier as name, #{Resource.demographics_summary_selects}").
      joins(Event.to_demographics_joins(report_options)).
      where("executable.rid = ?", resource_id).
      group("executable.exid, executable.identifier")
  end

  def summarize
    Executable.summary_select.where("executable.exid = ?", exid).first
  end

  def self.summary_select
    select("count(*) as count, min(ev_date) as first, max(ev_date) as last").joins("inner join Event on identifier = feature")
  end

end
