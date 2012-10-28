require 'test_helper'

class NewsAgenciesControllerTest < ActionController::TestCase
  setup do
    @news_agency = news_agencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news_agencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create news_agency" do
    assert_difference('NewsAgency.count') do
      post :create, news_agency: { name: @news_agency.name, url: @news_agency.url }
    end

    assert_redirected_to news_agency_path(assigns(:news_agency))
  end

  test "should show news_agency" do
    get :show, id: @news_agency
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news_agency
    assert_response :success
  end

  test "should update news_agency" do
    put :update, id: @news_agency, news_agency: { name: @news_agency.name, url: @news_agency.url }
    assert_redirected_to news_agency_path(assigns(:news_agency))
  end

  test "should destroy news_agency" do
    assert_difference('NewsAgency.count', -1) do
      delete :destroy, id: @news_agency
    end

    assert_redirected_to news_agencies_path
  end
end
