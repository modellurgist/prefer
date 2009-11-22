require 'test_helper'

class AlternativesSetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alternatives_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alternatives_set" do
    assert_difference('AlternativesSet.count') do
      post :create, :alternatives_set => { }
    end

    assert_redirected_to alternatives_set_path(assigns(:alternatives_set))
  end

  test "should show alternatives_set" do
    get :show, :id => alternatives_sets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => alternatives_sets(:one).to_param
    assert_response :success
  end

  test "should update alternatives_set" do
    put :update, :id => alternatives_sets(:one).to_param, :alternatives_set => { }
    assert_redirected_to alternatives_set_path(assigns(:alternatives_set))
  end

  test "should destroy alternatives_set" do
    assert_difference('AlternativesSet.count', -1) do
      delete :destroy, :id => alternatives_sets(:one).to_param
    end

    assert_redirected_to alternatives_sets_path
  end
end
