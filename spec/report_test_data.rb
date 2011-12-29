class ReportTestData
  USERNAME_1 = "username1"
  DEPARTMENT_ONE_NAME = "dept1"
  GROUP_ONE_NAME = "group1"
  DEPARTMENT_NO_USE = "deptnouse"
  GROUP_NO_USE = "groupnouse"
  EXECUTABLE_IDENTIFIER_1 = "id1"
  EXECUTABLE_IDENTIFIER_NO_USE = "idunsed"
  RESOURCE_NAME_1 = "resource1"

  COLLEGE_ONE_NAME = "college1"
  COLLEGE_NO_USE = "collegenouse"

  def self.setup_medical_resources_and_events
    resource_1 = FactoryGirl.create(:resource, :name => RESOURCE_NAME_1)

    purchase1_1 = FactoryGirl.create(:purchase, :fy10 => 100, :resource => resource_1)
    purchase1_2 = FactoryGirl.create(:purchase, :fy10 => 100, :fy11 => 300, :resource => resource_1)

    group1 = FactoryGirl.create(:group, :name => GROUP_ONE_NAME)
    group2 = FactoryGirl.create(:group)
    group_no_use = FactoryGirl.create(:group, :name => GROUP_NO_USE)

    college1 = FactoryGirl.create(:college, :name => COLLEGE_ONE_NAME)
    college_no_use = FactoryGirl.create(:college, :name => COLLEGE_NO_USE)

    department1 = FactoryGirl.create(:department, :name => DEPARTMENT_ONE_NAME, :colleges => [college1])
    department2 = FactoryGirl.create(:department, :name => "dept2")
    department3 = FactoryGirl.create(:department, :name => "dept3")

    department_no_use = FactoryGirl.create(:department, :name => DEPARTMENT_NO_USE)

    person1 = FactoryGirl.create(:person, :department => department1)
    person2 = FactoryGirl.create(:person, :department => department1)
    person3 = FactoryGirl.create(:person, :department => department2)
    person_no_use = FactoryGirl.create(:person, :department => department_no_use)

    user1 = FactoryGirl.create(:user, :username => USERNAME_1, :group => group1, :person => person1)
    user2 = FactoryGirl.create(:user, :username => "username2", :group => group1, :person => person2)
    user3 = FactoryGirl.create(:user, :username => "username3", :group => group2, :person => person3)

    user_no_use = FactoryGirl.create(:user, :group => group_no_use, :person => person_no_use)

    exec1 = FactoryGirl.create(:executable, :identifier => EXECUTABLE_IDENTIFIER_1,  :resource => resource_1)
    exec2 = FactoryGirl.create(:executable, :resource => resource_1)
    exec_unused = FactoryGirl.create(:executable, :identifier => EXECUTABLE_IDENTIFIER_NO_USE, :resource => resource_1)

    event1_1 = FactoryGirl.create(:event, :process_user => user1, :executable => exec1)
    event1_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec1)
    event1_3 = FactoryGirl.create(:event, :process_user => user3, :executable => exec1)
    event2_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec2)

    [exec1, exec2, exec_unused]
  end

  USED_TWICE_RESOURCE_NAME = "resource_twice"
  USED_TWICE_EXECUTABLE_IDENTIFIER = "exec_used_twice"

  NON_TECH_RESOURCE_NAME = "nontechresource"
  TECH_RESOURCE_NAME = "techresource"
  NON_TECH_EXECUTABLE_IDENTIFIER = "nontechexecutable"
  TECH_EXECUTABLE_IDENTIFIER = "techexecutable"

  NON_TECH_GROUP_NAME = "test_pi"
  TECH_GROUP_NAME = "tech"
  NON_TECH_USERNAME = "gradstudent01"
  TECH_USERNAME = "vestrum"

  TECH_DEPARTMENT_NAME = "cs_tech"
  NON_TECH_DEPARTMENT_NAME = "bio_non_tech"

  NON_TECH_COLLEGE_NAME = "cbs_non_tech"
  TECH_COLLEGE_NAME = "cse_tech"

  def self.quick_user(username, group_name, department_name, college_name)
    group = FactoryGirl.create(:group, :name => group_name)
    college = FactoryGirl.create(:college, :name => college_name)
    department = FactoryGirl.create(:department, :name => department_name, :colleges => [college])
    person = FactoryGirl.create(:person, :department => department)
    FactoryGirl.create(:user, :username => username, :group => group, :person => person)
  end


  def self.setup_tech_and_non_tech_users
    user_non_tech = quick_user(NON_TECH_USERNAME, NON_TECH_GROUP_NAME, NON_TECH_DEPARTMENT_NAME, NON_TECH_COLLEGE_NAME)
    user_tech = quick_user(TECH_USERNAME, TECH_GROUP_NAME, TECH_DEPARTMENT_NAME, TECH_COLLEGE_NAME)
    return user_non_tech, user_tech
  end

  def self.setup_two_executables # Creates a resource with two executables, one that is used by user in tech group and one by user in non-tech group
    resource = FactoryGirl.create(:resource, :name => USED_TWICE_RESOURCE_NAME)

    user_non_tech, user_tech = setup_tech_and_non_tech_users

    exec_tech = FactoryGirl.create(:executable,  :resource => resource, :identifier => TECH_EXECUTABLE_IDENTIFIER)
    exec_non_tech = FactoryGirl.create(:executable,  :resource => resource, :identifier => NON_TECH_EXECUTABLE_IDENTIFIER)

    FactoryGirl.create(:event, :process_user => user_non_tech, :executable => exec_non_tech)
    FactoryGirl.create(:event, :process_user => user_tech, :executable => exec_tech)


  end

  def self.setup_used_twice_resource(options = {}) # one used by tech, one used by non tech
    options.reverse_merge!({:collectl => true, :flexlm => true, :module => true})
    resource_1 = FactoryGirl.create(:resource, :name => USED_TWICE_RESOURCE_NAME)

    user_non_tech = quick_user(NON_TECH_USERNAME, NON_TECH_GROUP_NAME, NON_TECH_DEPARTMENT_NAME, NON_TECH_COLLEGE_NAME)
    user_tech = quick_user(TECH_USERNAME, TECH_GROUP_NAME, TECH_DEPARTMENT_NAME, TECH_COLLEGE_NAME)

    if options[:flexlm]
      exec1 = FactoryGirl.create(:executable,  :resource => resource_1, :identifier => USED_TWICE_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:event, :process_user => user_non_tech, :executable => exec1)
      FactoryGirl.create(:event, :process_user => user_tech, :executable => exec1)
    end

    if options[:collectl]
      collectl_executable = FactoryGirl.create(:collectl_executable, :resource => resource_1, :name => USED_TWICE_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:collectl_execution, :user => user_non_tech, :collectl_executable => collectl_executable)
      FactoryGirl.create(:collectl_execution, :user => user_tech, :collectl_executable => collectl_executable)
    end

    if options[:module]
      software_module = FactoryGirl.create(:module, :resource => resource_1, :name => USED_TWICE_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:module_load, :user => user_non_tech, :module => software_module)
      FactoryGirl.create(:module_load, :user => user_tech, :module => software_module)

    end

  end

  def self.setup_two_resources(options = {}) # Creates a resource used once by a user in tech group and once by a non-tech user
    options.reverse_merge!({:collectl => true, :flexlm => true, :module => true})
    resource_tech = FactoryGirl.create(:resource, :name => TECH_RESOURCE_NAME)
    resource_non_tech = FactoryGirl.create(:resource, :name => NON_TECH_RESOURCE_NAME)

    user_non_tech, user_tech = setup_tech_and_non_tech_users

    if options[:flexlm]
      exec_tech = FactoryGirl.create(:executable,  :resource => resource_tech, :identifier => TECH_EXECUTABLE_IDENTIFIER)
      exec_non_tech = FactoryGirl.create(:executable,  :resource => resource_non_tech, :identifier => NON_TECH_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:event, :process_user => user_non_tech, :executable => exec_non_tech)
      FactoryGirl.create(:event, :process_user => user_tech, :executable => exec_tech)

    end

    if options[:collectl]
      collectl_executable_tech = FactoryGirl.create(:collectl_executable, :resource => resource_tech, :name => TECH_EXECUTABLE_IDENTIFIER)
      collectl_executable_non_tech = FactoryGirl.create(:collectl_executable, :resource => resource_non_tech, :name => NON_TECH_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:collectl_execution, :user => user_non_tech, :collectl_executable => collectl_executable_non_tech)
      FactoryGirl.create(:collectl_execution, :user => user_tech, :collectl_executable => collectl_executable_tech)
    end

    if options[:module]
      module_tech = FactoryGirl.create(:module, :resource => resource_tech, :name => TECH_EXECUTABLE_IDENTIFIER)
      module_non_tech = FactoryGirl.create(:module, :resource => resource_non_tech, :name => NON_TECH_EXECUTABLE_IDENTIFIER)

      FactoryGirl.create(:module_load, :user => user_non_tech, :module => module_non_tech)
      FactoryGirl.create(:module_load, :user => user_tech, :module => module_tech)
    end

  end



end