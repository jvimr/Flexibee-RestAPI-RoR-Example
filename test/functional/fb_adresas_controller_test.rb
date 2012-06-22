require 'test_helper'

class FbAdresasControllerTest < ActionController::TestCase
  setup do
    @fb_adresa = fb_adresas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fb_adresas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fb_adresa" do
    assert_difference('FbAdresa.count') do
      post :create, :fb_adresa => @fb_adresa.attributes
    end

    assert_redirected_to fb_adresa_path(assigns(:fb_adresa))
  end

  test "should show fb_adresa" do
    get :show, :id => @fb_adresa.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fb_adresa.to_param
    assert_response :success
  end

  test "should update fb_adresa" do
    put :update, :id => @fb_adresa.to_param, :fb_adresa => @fb_adresa.attributes
    assert_redirected_to fb_adresa_path(assigns(:fb_adresa))
  end

  test "should destroy fb_adresa" do
    assert_difference('FbAdresa.count', -1) do
      delete :destroy, :id => @fb_adresa.to_param
    end

    assert_redirected_to fb_adresas_path
  end
end
