require 'test_helper'

class PerkApiControllerTest < ActionController::TestCase
  test "should get list_all" do
    get :list_all
    assert_response :success
  end

  test "should get list_since" do
    get :list_since
    assert_response :success
  end

end
