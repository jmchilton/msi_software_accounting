class College < ReadOnlyModel
  set_table_name "colleges"
  set_primary_key "id"

  has_and_belongs_to_many :departments,
                          :join_table => "department_colleges",
                          :foreign_key => :college_id,
                          :association_foreign_key => :dept_id,
                          :class_name => 'Department'

  scope :resources, select("colleges.id, ex.rid").
                    joins(" INNER JOIN department_colleges dc ON dc.college_id = colleges.id
                            INNER JOIN departments d ON d.id = dc.dept_id
                            INNER JOIN persons person ON person.dept_id = d.id
                            INNER JOIN users u ON u.person_id = person.id
                            INNER JOIN event e ON e.unam = u.username
                            INNER JOIN executable ex on e.feature = ex.identifier").
                    where("e.operation = 'OUT'").
                    group("colleges.id, ex.rid")


  scope :report, select("colleges.name, " +  
                        "count(*) as num_packages, " + 
                        "sum(fy10) as fy10," +     
                        "sum(fy11) as fy11," + 
                        "sum(fy12) as fy12," + 
                        "sum(fy13) as fy13").
                  joins("inner join (#{resources.to_aliased_sql('ic')}) cr on colleges.id = cr.id
                         inner join (select p.rid as rid, 
                                            sum(p.fy10) as fy10, 
                                            sum(p.fy11) as fy11, 
                                            sum(p.fy12) as fy12, 
                                            sum(p.fy13) as fy13 
                                     from purchase p group by p.rid) ps
                        on ps.rid = cr.rid").
                  order("colleges.name ASC").
                  group("colleges.name")

end
