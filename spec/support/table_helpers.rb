require 'controllers/helpers'

module TableHelpers
  include Helpers

  module ClassMethods
    def before_each_setup_parent
      before(:each) {
        dynamic_setup_parent
      }
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def dynamic_setup_parent
    subject_class_name = subject.class.name
    parent_model = /^(Resource|Executable|User|Group|Department|College)(.*)(Report)?Controller/.match(subject_class_name)[1]
    eval("setup_parent '#{parent_model.downcase}'")
  end

  def setup_parent_resource
    setup_parent "resource"
  end

  def setup_parent_executable
    setup_parent "executable"
  end

  def setup_parent(type)
    type_as_symbol = type.to_sym
    self.class.let(type_as_symbol) { FactoryGirl.create(type_as_symbol)}
    self.class.let(:index_params) { {(type.to_s + '_id').to_sym => eval(type).id } }
  end

  def json_response
    ActiveSupport::JSON.decode(response.body)
  end

  def test_row_for_fields(fields)
    hash = {}
    fields.each { |field| hash[field[:field]] = "test" }
    hash
  end

  def test_rows_for_fields(fields)
    (1..2).map { test_row_for_fields(fields)}
  end

  def test_relation_for_fields(fields)
    test_rows = test_rows_for_fields(fields)
    row_relation = double("row_relation")
    row_relation.stub(:all).and_return(test_rows)
    row_relation
  end

  def it_should_setup_table_variables
    assigns(:rows).should_not be_nil
    assigns(:fields).should be_an Array
    assigns(:fields).each { |field| field.should be_a Hash }
    assigns(:title).should be_a String 
  end

  def it_should_assign_field(expected_field)
    matched_field = assigns(:fields).find { |field| expected_field[:field] == field[:field] }
    matched_field.should_not be_blank
  end

  def it_should_assign_fields(expected_fields)
    expected_fields.each { |expected_field| it_should_assign_field expected_field }
  end

  def it_should_set_rows_to(rows)
    assigns(:rows).should eql(rows)
  end

  def it_should_assign_links_with(procedure_name)
    assigned_link_field[:link_proc].should == procedure_name
  end

  def assigned_row_with_id(id)
    assigns(:rows).find { |row| row.id == id }
  end

  def assigned_link_field
    assigned_field(:link)
  end

  def assigned_field(key)
    subject.class::FIELDS.find {|field| field[:field].respond_to?(:to_sym) && field[:field].to_sym == key }
  end

  def it_should_paginate
    assigns(:allow_pagination).should == true
    assigns(:scroll).should == false
    assigns(:rows_per_page).should == ApplicationController::DEFAULT_NUM_ROWS_PAGINATE
    assigns(:row_list).should == ApplicationController::ROW_LIST_PAGINATE
  end

  def it_should_not_paginate
    assigns(:allow_pagination).should == false
    assigns(:scroll).should == true
    assigns(:rows_per_page).should be > 100
    assigns(:rows_per_page).should == ApplicationController::DEFAULT_NUM_ROWS_NO_PAGINATE
    assigns(:row_list).should == ApplicationController::ROW_LIST_NO_PAGINATE
  end

  def it_should_respond_successfully_with_table
    it_should_respond_successfully
    it_should_setup_table_variables
  end

  def it_should_respond_successfully_with_paginating_table
    it_should_respond_successfully_with_table
    it_should_paginate
  end



  def it_should_respond_successfully_with_report_options
    it_should_respond_successfully

    response.body.should =~ /build_report_button/
  end

  def it_should_respond_successfully_with_model_index

  end

  def it_should_respond_successfully_with_report
    it_should_respond_successfully
    it_should_setup_table_variables
    it_should_not_paginate
  end

  def expected_report_options
    hash_including(:from => @from, :to => @to)
  end

  shared_examples_for "standard model GET index" do
    before(:each) {
      get :index, index_params_if_set
    }

    specify { it_should_respond_successfully_with_paginating_table }
  end

  shared_examples_for "standard report GET index" do

    let (:row_relation) { test_relation_for_fields(subject.class::FIELDS) }

    before(:each) {
      get :index, index_params_if_set
    }
    specify { it_should_respond_successfully_with_report }
    specify { it_should_set_rows_to(row_relation) }
    specify { it_should_assign_fields subject.class::FIELDS }
  end

  def index_params_if_set
    respond_to?(:index_params) ? index_params : {}
  end

  shared_examples_for "standard report GET new" do
    before(:each) {
      get :new, index_params_if_set
    }

    specify { it_should_respond_successfully_with_report_options }
  end

  def stub_report_method(klazz, method)
    klazz.stub(method).with(expected_report_options).and_return(row_relation)
  end


end