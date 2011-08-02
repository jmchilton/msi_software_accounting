require 'test_helper'

class ExecutablesControllerTest < ActionController::TestCase
  fixtures :swacct_executable

  setup do
    @executable = swacct_executable(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:executables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create executable" do
    assert_difference('Executable.count') do
      post :create, :executable => @executable.attributes
    end

    assert_redirected_to executable_path(assigns(:executable))
  end

  test "should show executable" do
    get :show, :id => @executable.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @executable.to_param
    assert_response :success
  end

  test "should update executable" do
    put :update, :id => @executable.to_param, :executable => @executable.attributes
    assert_redirected_to executable_path(assigns(:executable))
  end

  test "should destroy executable" do
    assert_difference('Executable.count', -1) do
      delete :destroy, :id => @executable.to_param
    end

    assert_redirected_to executables_path
  end
end
