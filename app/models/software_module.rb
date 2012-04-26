# Would prefer the name Module, but that understandably doesn't seem to play well with Ruby
class SoftwareModule < ActiveRecord::Base
  set_table_name "modules"

  belongs_to :resource

  validates :name, :presence => true

  def summarize
    SoftwareModule.summary_select.where("modules.name = ?", name).first
  end

  def self.summary_select
    SoftwareModule.select("count(*) as count, min(module_loads.date) as first, max(module_loads.date) as last").joins("inner join module_loads on module_loads.name = modules.name")
  end

end