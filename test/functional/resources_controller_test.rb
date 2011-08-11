require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  fixtures :resources

  setup do
    @resource = resources(:resource_one)
  end

  test "show_report contains resource_1" do
    get :show_report
    assert_response :success
    assert_not_nil assigns(:rows)
    assert_equal assigns(:rows)[0].name, "resource_1"
    assert_equal assigns(:rows)[0].fy10, 10
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  test "should show resource" do
    get :show, :id => @resource.to_param
    assert_response :success
  end

end
