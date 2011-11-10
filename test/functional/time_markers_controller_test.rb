require 'test_helper'

class TimeMarkersControllerTest < ActionController::TestCase
  setup do
    @time_marker = time_markers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_markers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_marker" do
    assert_difference('TimeMarker.count') do
      post :create, time_marker: @time_marker.attributes
    end

    assert_redirected_to time_marker_path(assigns(:time_marker))
  end

  test "should show time_marker" do
    get :show, id: @time_marker.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_marker.to_param
    assert_response :success
  end

  test "should update time_marker" do
    put :update, id: @time_marker.to_param, time_marker: @time_marker.attributes
    assert_redirected_to time_marker_path(assigns(:time_marker))
  end

  test "should destroy time_marker" do
    assert_difference('TimeMarker.count', -1) do
      delete :destroy, id: @time_marker.to_param
    end

    assert_redirected_to time_markers_path
  end
end
