FactoryGirl.define do

  def readonly_factory(name)
    factory name do
      after_build  { |object| object.stub(:readonly?).and_return(false) }
      after_create { |object| object.unstub(:readonly?) }
      yield
    end
  end   

  readonly_factory :college do
    sequence(:name) { |index| "College#{index}" }
  end

end