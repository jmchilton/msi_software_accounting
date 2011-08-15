class College < ReadOnlyModel
  set_table_name "colleges"
  set_primary_key "id"

  has_and_belongs_to_many :departments,
                          :join_table => "department_colleges",
                          :foreign_key => :college_id,
                          :association_foreign_key => :dept_id,
                          :class_name => 'Department'

  def self.resources(from = nil, to = nil)
    select("colleges.id, ex.rid").
    joins("INNER JOIN department_colleges dc ON dc.college_id = colleges.id
           INNER JOIN departments d ON d.id = dc.dept_id
           INNER JOIN persons person ON person.dept_id = d.id
           INNER JOIN users u ON u.person_id = person.id
           INNER JOIN (#{Event.valid_events(from, to).to_sql}) e ON e.unam = u.username
           INNER JOIN executable ex on e.feature = ex.identifier").
    group("colleges.id, ex.rid")
  end


  def self.report(from = nil, to = nil)
    select("colleges.name,
            count(*) as num_packages,
            sum(fy10) as fy10,
            sum(fy11) as fy11,
            sum(fy12) as fy12,
            sum(fy13) as fy13").
    joins("inner join (#{resources(from, to).to_aliased_sql('ic')}) cr on colleges.id = cr.id
           left join (#{Purchase.resource_summary.to_sql}) ps on ps.rid = cr.rid").
    order("colleges.name ASC").
    group("colleges.name")
  end
end
