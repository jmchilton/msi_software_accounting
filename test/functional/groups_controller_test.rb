require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  fixtures :groups

  setup do
    @group = groups(:group_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should show group" do
    get :show, :id => @group.to_param
    assert_response :success
  end

end
