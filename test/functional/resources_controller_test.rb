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
    assert_equal @controller.rows[0].name, "resource_1"
    assert_equal @controller.rows[0].fy10, 10
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource" do
    assert_difference('Resource.count') do
      post :create, :resource => @resource.attributes
    end

    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should show resource" do
    get :show, :id => @resource.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @resource.to_param
    assert_response :success
  end

  test "should update resource" do
    put :update, :id => @resource.to_param, :resource => @resource.attributes
    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, :id => @resource.to_param
    end

    assert_redirected_to resources_path
  end
end
