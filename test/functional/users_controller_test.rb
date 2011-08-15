require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users

  setup do
    @user = users(:user_bob)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rows)
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

end
