class ReportTestData
  DEPARTMENT_ONE_NAME = "dept1"
  GROUP_ONE_NAME = "group1"
  DEPARTMENT_NO_USE = "deptnouse"
  GROUP_NO_USE = "groupnouse"

  def self.setup_medical_resources_and_events
    resource_1 = FactoryGirl.create(:resource)

    purchase1_1 = FactoryGirl.create(:purchase, :fy10 => 100, :resource => resource_1)
    purchase1_2 = FactoryGirl.create(:purchase, :fy10 => 100, :fy11 => 300, :resource => resource_1)

    group1 = FactoryGirl.create(:group, :name => GROUP_ONE_NAME)
    group2 = FactoryGirl.create(:group)
    group_no_use = FactoryGirl.create(:group, :name => GROUP_NO_USE)

    department1 = FactoryGirl.create(:department, :name => DEPARTMENT_ONE_NAME)
    department2 = FactoryGirl.create(:department, :name => "dept2")
    department3 = FactoryGirl.create(:department, :name => "dept3")

    department_no_use = FactoryGirl.create(:department, :name => DEPARTMENT_NO_USE)

    person1 = FactoryGirl.create(:person, :department => department1)
    person2 = FactoryGirl.create(:person, :department => department1)
    person3 = FactoryGirl.create(:person, :department => department2)
    person_no_use = FactoryGirl.create(:person, :department => department_no_use)

    user1 = FactoryGirl.create(:user, :username => "username1", :group => group1, :person => person1)
    user2 = FactoryGirl.create(:user, :username => "username2", :group => group1, :person => person2)
    user3 = FactoryGirl.create(:user, :username => "username3", :group => group2, :person => person3)

    user_no_use = FactoryGirl.create(:user, :group => group_no_use, :person => person_no_use)

    exec1 = FactoryGirl.create(:executable, :identifier => "id1",  :resource => resource_1)
    exec2 = FactoryGirl.create(:executable, :resource => resource_1)
    exec_unused = FactoryGirl.create(:executable, :resource => resource_1)

    event1_1 = FactoryGirl.create(:event, :process_user => user1, :executable => exec1)
    event1_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec1)
    event1_3 = FactoryGirl.create(:event, :process_user => user3, :executable => exec1)
    event2_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec2)

    [exec1, exec2, exec_unused]
  end

end