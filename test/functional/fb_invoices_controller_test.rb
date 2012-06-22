require 'test_helper'

class FbInvoicesControllerTest < ActionController::TestCase
  setup do
    @fb_invoice = fb_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fb_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fb_invoice" do
    assert_difference('FbInvoice.count') do
      post :create, :fb_invoice => @fb_invoice.attributes
    end

    assert_redirected_to fb_invoice_path(assigns(:fb_invoice))
  end

  test "should show fb_invoice" do
    get :show, :id => @fb_invoice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fb_invoice.to_param
    assert_response :success
  end

  test "should update fb_invoice" do
    put :update, :id => @fb_invoice.to_param, :fb_invoice => @fb_invoice.attributes
    assert_redirected_to fb_invoice_path(assigns(:fb_invoice))
  end

  test "should destroy fb_invoice" do
    assert_difference('FbInvoice.count', -1) do
      delete :destroy, :id => @fb_invoice.to_param
    end

    assert_redirected_to fb_invoices_path
  end
end
