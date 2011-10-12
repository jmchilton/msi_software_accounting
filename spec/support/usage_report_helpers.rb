
module UsageReportHelpers

  module ClassMethods

    def before_each_setup_parent
      before(:each) {
        subject_class_name = subject.class.name
        if subject_class_name.starts_with? "Resource"
          setup_parent_resource
        else
          setup_parent_executable
        end
      }
    end


    def before_each_stub_usage_report
      before(:each) {
        subject_class_name = subject.class.name
        report_model = /(Resource|Executable)(.*)ReportController/.match(subject_class_name)[2]
        if subject_class_name.starts_with? "Resource"
          stub_resource_report_method(eval(report_model))
        else
          stub_executable_report_method(eval(report_model))
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