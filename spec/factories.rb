def readonly
  after_build  { |object| object.stub(:readonly?).and_return(false) }
  after_create { |object| object.unstub(:readonly?) }
end

FactoryGirl.define do

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
  end

  factory :resource, :class => Resource do
    readonly
  end

  factory :executable, :class => Executable do
    sequence(:identifier) { |index| "feature #{index}" }
    sequence(:comment) { |index| "comment #{index}" }
  end

end
