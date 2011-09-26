class FlexlmUserSnapshot < ReadOnlyModel
  set_table_name "flexlm_user_snapshots"

  belongs_to :flexlm_app_snapshot
  belongs_to :process_user, :class_name => 'User', :foreign_key => "username", :primary_key => "username"

end
