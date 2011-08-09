require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  fixtures :event

  setup do
    @event = event(:event_one)
  end

  test "should have user association fixture" do 
    assert @event.process_user.username == "bob"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should show event" do
    get :show, :id => @event.to_param
    assert_response :success
  end

end
