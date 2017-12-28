require 'test_helper'

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get policies_index_url
    assert_response :success
  end

  test "should get show" do
    get policies_show_url
    assert_response :success
  end

  test "should get due_today" do
    get policies_due_today_url
    assert_response :success
  end

  test "should get motor_declarations" do
    get policies_motor_declarations_url
    assert_response :success
  end

  test "should get travel_declarations" do
    get policies_travel_declarations_url
    assert_response :success
  end

end
