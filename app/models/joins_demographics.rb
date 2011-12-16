module JoinsDemographics
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def join_valid_users_and_groups(report_options = {})
      group_join_condition = "users.gid = groups.gid"
      users_join_condition = join_users_on
      unless report_options[:limit_users].nil?
        users_join_condition = "(#{users_join_condition} and users.username in #{sql_user_list(report_options[:limit_users])} )"
      end
      if report_options[:exclude_employees]
        group_join_condition = "(#{group_join_condition} and groups.name not in #{Group::EMPLOYEE_GROUPS})"
      end
      "INNER JOIN users on #{users_join_condition}
       INNER JOIN groups on #{group_join_condition} "
    end

    private

    def sql_user_list(list)
      sanitize_sql_array(["(#{(list.map{|x| "?"}).join(",")})"] + list)
    end

  end

end