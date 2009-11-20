require 'test_helper'

class AlternativesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alternatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alternative" do
    assert_difference('Alternative.count') do
      post :create, :alternative => { }
    end

    assert_redirected_to alternative_path(assigns(:alternative))
  end

  test "should show alternative" do
    get :show, :id => alternatives(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => alternatives(:one).to_param
    assert_response :success
  end

  test "should update alternative" do
    put :update, :id => alternatives(:one).to_param, :alternative => { }
    assert_redirected_to alternative_path(assigns(:alternative))
  end

  test "should destroy alternative" do
    assert_difference('Alternative.count', -1) do
      delete :destroy, :id => alternatives(:one).to_param
    end

    assert_redirected_to alternatives_path
  end
end
