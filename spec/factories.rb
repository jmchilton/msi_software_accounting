def readonly
  after_build  { |object| object.stub(:readonly?).and_return(false) }
  after_create { |object| object.unstub(:readonly?) }
end

FactoryGirl.define do

  factory :collectl_execution do
    start_time Time.now - 1.day
    end_time Time.now - 2.days
    sequence(:host) { |index| "Host#{index}"}
    sequence(:pid) { |index| 1000 + index }

    readonly
  end

  factory :raw_collectl_execution do
    start_time Time.now - 1.day
    end_time Time.now - 2.days
    sequence(:host) { |index| "Host#{index}"}
    sequence(:pid) { |index| 1000 + index }

    readonly
  end

  factory :flexlm_app_snapshot do
    for_date Time.now
    association :executable, :factory => :executable
    readonly
  end

  factory :flexlm_user_snapshot do

    readonly
  end

  factory :college do
    sequence(:name) { |index| "College#{index}" }
    readonly
  end

  factory :department, :class => Department do
    sequence(:name) { |index| "Department#{index}" }
    readonly
  end

  factory :user, :class => User do
    sequence(:username) { |index| "user #{index}"  }
    sequence(:uid) { |index| 20000 + index }
    readonly
  end

  factory :event, :class => Event do
    #sequence(:feature) { |index| "feature #{index}" }
    #sequence(:vendor) { |index| "vendor #{index}" }
    operation "OUT"
    readonly
  end

  factory :group, :class => Group do
    readonly
  end

  factory :person, :class => Person do
    readonly
  end

  factory :purchase, :class => Purchase do
    fy10 0
    fy11 0
    fy12 0
    fy13 0
    flexlm '1'
    os "Linux"
  end


  factory :resource, :class => Resource do
    readonly
  end

  factory :executable, :class => Executable do
    sequence(:identifier) { |index| "feature #{index}" }
    sequence(:comment) { |index| "comment #{index}" }
  end

  factory :collectl_executable, :class => CollectlExecutable do
    sequence(:name) { |index| "exectuable_#{index}" }
  end

  factory :module, :class => SoftwareModule do

  end

  factory :module_load, :class => ModuleLoad do

  end

end
