module Helpers

  def it_should_respond_successfully_with_template(template = self.class.description.split(" ").last)
    response.should be_success
    response.should render_template(template)
  end

  shared_examples_for "standard GET index" do
    before(:each) { get :index }

    specify { it_should_respond_successfully_with_template }
  end

  shared_examples_for "standard GET show" do |example_proc|

    before(:each) {
      example = example_proc.call()
      id = example.to_param
      id.should_not be_blank
      get :show, :id => id
    }

    specify { it_should_respond_successfully_with_template }
  end

end