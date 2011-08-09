class College < ReadOnlyModel
  set_table_name "colleges"
  set_primary_key "id"

  has_and_belongs_to_many :departments,
                          :join_table => "department_colleges",
                          :foreign_key => :college_id,
                          :association_foreign_key => :dept_id,
                          :class_name => 'Department'

  scope :resources, select("colleges.id, ex.rid").
                    joins(" as c
                            INNER JOIN department_colleges dc ON dc.college_id = c.id
                            INNER JOIN departments d ON d.id = dc.dept_id
                            INNER JOIN persons person ON person.dept_id = d.id
                            INNER JOIN users u ON u.person_id = person.id
                            INNER JOIN event e ON e.unam = u.username
                            INNER JOIN executable ex on e.feature = ex.identifier").
                    where("e.operation = 'OUT'").
                    group("c.id, ev.rid")


  scope :report, select("colleges.name, " +  
                        "count(*) as num_packages, " + 
                        "count(distinct purchase.pid) as num_purchases, " +            
                        "sum(purchase.fy10) as fy10," +     
                        "sum(purchase.fy11) as fy11," + 
                        "sum(purchase.fy12) as fy12," + 
                        "sum(purchase.fy13) as fy13").
                  where("event.operation = 'OUT'").
                  joins(:departments => { :people => {:users => { :events => { :executable => { :resource => :purchases } } } } }).
                  order("colleges.name ASC").
                  group("colleges.name, resources.rid")

end
