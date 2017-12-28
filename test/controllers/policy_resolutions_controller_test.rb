require 'test_helper'

class PolicyResolutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy_resolution = policy_resolutions(:one)
  end

  test "should get index" do
    get policy_resolutions_url
    assert_response :success
  end

  test "should get new" do
    get new_policy_resolution_url
    assert_response :success
  end

  test "should create policy_resolution" do
    assert_difference('PolicyResolution.count') do
      post policy_resolutions_url, params: { policy_resolution: {  } }
    end

    assert_redirected_to policy_resolution_url(PolicyResolution.last)
  end

  test "should show policy_resolution" do
    get policy_resolution_url(@policy_resolution)
    assert_response :success
  end

  test "should get edit" do
    get edit_policy_resolution_url(@policy_resolution)
    assert_response :success
  end

  test "should update policy_resolution" do
    patch policy_resolution_url(@policy_resolution), params: { policy_resolution: {  } }
    assert_redirected_to policy_resolution_url(@policy_resolution)
  end

  test "should destroy policy_resolution" do
    assert_difference('PolicyResolution.count', -1) do
      delete policy_resolution_url(@policy_resolution)
    end

    assert_redirected_to policy_resolutions_url
  end
end
