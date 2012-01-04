module OverviewHelpers

  def summary_double(name, extra_args)
    double(name, {:summarize => {:count => 5, :first => '2011-08-05 12:10:38', :last => '2011-08-29 12:10:29' }}.merge(extra_args))
  end

  shared_examples_for "controller assigning a summary" do
      specify { assigns(:summary)[:count].should eql(5) }
      specify { assigns(:summary)[:first].should eql('2011-08-05 12:10:38') }
      specify { assigns(:summary)[:last].should eql('2011-08-29 12:10:29') }
  end

  shared_examples_for "controller showing overview" do
    describe "as html" do
      let(:format) { :html }

      it_should_behave_like "controller assigning a summary"

      it "should render module fields partial" do
        response.should render_template("#{data_source}_overview/_fields")
      end

    end

    describe "as json" do
      let(:format) { :js }

      it "should set html of overview dom element" do
         response.body.should include("$(\"##{data_source}-overview\").html(")
      end

      it "should render module fields partial" do
        response.should render_template("#{data_source}_overview/_fields")
      end

    end

  end

  shared_examples_for "controller that can show overview" do
    before(:each) {
      get :show, :id => 1, :format => format
    }

    it_should_behave_like "controller showing overview"

  end



end