require 'test_helper'

class CollegesControllerTest < ActionController::TestCase
  fixtures :colleges

  setup do
    @college = colleges(:one)
  end

  test "show_report contains CFANS" do
    get :show_report
    assert_response :success    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colleges)
  end

  test "should show college" do
    get :show, :id => @college.to_param
    assert_response :success
  end

end
