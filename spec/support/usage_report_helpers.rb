
module UsageReportHelpers

  shared_examples_for "controller with usage reports for each model type" do
    describe "user reports" do
      let(:model_class) { User }
      let(:model_type) { "user" }

      it_should_behave_like "standard report GET new"
      it_should_behave_like "standard usage report GET index"
    end

    describe "college reports" do
      let(:model_class) { College }
      let(:model_type) { "college" }

      it_should_behave_like "standard report GET new"
      it_should_behave_like "standard usage report GET index"
    end

    describe "department reports" do
      let(:model_class) { Department }
      let(:model_type) { "department" }

      it_should_behave_like "standard report GET new"
      it_should_behave_like "standard usage report GET index"
    end

    describe "group reports" do
      let(:model_class) { Group }
      let(:model_type) { "group" }

      it_should_behave_like "standard report GET new"
      it_should_behave_like "standard usage report GET index"
    end
  end



  module ClassMethods

    def before_each_stub_usage_report(instance = nil)
      before(:each) {
        subject_class_name = subject.class.name
        usage_controller_pattern = /^(Batch)?(Resource|Executable)(.*)ReportController$/
        object_usage_controller_pattern = /^(User|Group|College|Department|Model)(Resources|Executables)ReportController$/
        usage_match = usage_controller_pattern.match(subject_class_name)
        if not usage_match.nil?
          report_model = usage_match[3]
          if report_model == "Model"
            report_model = model_class.name
          end
          if subject_class_name.match "Resource"
            stub_resource_report_method(eval(report_model), instance)
          else
            stub_executable_report_method(eval(report_model), instance)
            end
        else
          object_usage_match = object_usage_controller_pattern.match(subject_class_name)
          object_class_name = object_usage_match[1]
          if object_class_name != "Model"
            object_class = eval(object_class_name)
          else
            object_class = model_class
          end
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

  def stub_resource_report_method(klazz, instance)
    if instance.nil?
      instance = resource
    end
    klazz.stub(:resource_report).with(instance.id, expected_report_options).and_return(row_relation)
  end

  def stub_executable_report_method(klazz, instance)
    if instance.nil?
      instance = executable
    end
    klazz.stub(:executable_report).with(instance.id, expected_report_options).and_return(row_relation)
  end

  shared_examples_for "standard usage report GET index" do
    before_each_stub_usage_report

    it_should_behave_like "standard report GET index"
  end

end