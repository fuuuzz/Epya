require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

end
