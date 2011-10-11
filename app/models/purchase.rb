class Purchase < ActiveRecord::Base
  REPORT_SELECT_FIELDS = "count(*) as num_packages, sum(fy10) as fy10, sum(fy11) as fy11, sum(fy12) as fy12, sum(fy13) as fy13"
  OPERATING_SYSTEMS = ["Linux/Windows", "Windows", "Linux"]
  FLEXLM = {"0" => "No", "1" => "Yes"}

  set_table_name "purchase"
  set_primary_key "pid"

  belongs_to :resource, :foreign_key => "rid"

  def self.resource_summary   
    select("rid, sum(fy10) as fy10, 
            sum(fy11) as fy11, sum(fy12) as fy12, 
            sum(fy13) as fy13, 0 as flexlm"). # TODO: Remve hack 0 as flexlm, need to find a way to indicate these are purchases
    group("rid")
  end

  def self.summary_left_join(resource_identifier)
    "left join (#{Purchase.resource_summary.to_sql}) ps on ps.rid = #{resource_identifier}"
  end

  validates_numericality_of :fy10, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :fy11, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :fy12, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :fy13, :only_integer => true, :greater_than_or_equal_to => 0
  validates_presence_of :rid
  validates_inclusion_of :os, :in => OPERATING_SYSTEMS, :allow_nil => true
  #validates_inclusion_of :flexlm, :in => ["0", "1"], 

  after_initialize :default_values

  private
    def default_values
      self.fy10 ||= 0
      self.fy11 ||= 0
      self.fy12 ||= 0
      self.fy13 ||= 0
      self.flexlm ||= 0
    end

end
