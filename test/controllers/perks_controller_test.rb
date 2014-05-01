require 'test_helper'

class PerksControllerTest < ActionController::TestCase
  setup do
    @perk = perks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:perks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perk" do
    assert_difference('Perk.count') do
      post :create, perk: {  }
    end

    assert_redirected_to perk_path(assigns(:perk))
  end

  test "should show perk" do
    get :show, id: @perk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @perk
    assert_response :success
  end

  test "should update perk" do
    patch :update, id: @perk, perk: {  }
    assert_redirected_to perk_path(assigns(:perk))
  end

  test "should destroy perk" do
    assert_difference('Perk.count', -1) do
      delete :destroy, id: @perk
    end

    assert_redirected_to perks_path
  end
end
