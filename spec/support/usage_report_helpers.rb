
module UsageReportHelpers

  module ClassMethods

    def before_each_stub_usage_report
      before(:each) {
        subject_class_name = subject.class.name
        usage_controller_pattern = /^(Resource|Executable)(.*)ReportController$/
        object_usage_controller_pattern = /^(User|Group|College|Department)(Resources|Executables)ReportController$/
        usage_match = usage_controller_pattern.match(subject_class_name)
        if not usage_match.nil?
          report_model = usage_match[2]
          if subject_class_name.starts_with? "Resource"
            stub_resource_report_method(eval(report_model))
          else
            stub_executable_report_method(eval(report_model))
            end
        else
          object_usage_match = object_usage_controller_pattern.match(subject_class_name)
          object_class_name = object_usage_match[1]
          object_class = eval(object_class_name)
          type = object_usage_match[2].downcase
          method = (type + "_report").to_sym

          object_class.any_instance.stub(method).with(expected_report_options).and_return(row_relation)
        end
      }
    end

  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def stub_resource_report_method(klazz)
    klazz.stub(:resource_report).with(resource.id, expected_report_options).and_return(row_relation)
  end

  def stub_executable_report_method(klazz)
    klazz.stub(:executable_report).with(executable.id, expected_report_options).and_return(row_relation)
  end

  shared_examples_for "standard usage report GET index" do
    before_each_stub_usage_report

    it_should_behave_like "standard report GET index"
  end

end