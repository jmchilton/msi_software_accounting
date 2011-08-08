require 'test_helper'

class DepartmentsControllerTest < ActionController::TestCase
  fixtures :departments

  setup do
    @department = departments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departments)
  end


  test "should show department" do
    get :show, :id => @department.to_param
    assert_response :success
  end

end
