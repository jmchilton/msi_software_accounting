require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  fixtures :persons

  setup do
    @person = persons(:person_bob)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should show person" do
    get :show, :id => @person.to_param
    assert_response :success
  end

end
