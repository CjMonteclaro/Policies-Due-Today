require 'test_helper'

class ApprovalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @approval = approvals(:one)
  end

  test "should get index" do
    get approvals_url
    assert_response :success
  end

  test "should get new" do
    get new_approval_url
    assert_response :success
  end

  test "should create approval" do
    assert_difference('Approval.count') do
      post approvals_url, params: { approval: { approval_type: @approval.approval_type, approved: @approval.approved, approver_id: @approval.approver_id, policy_resolution_id: @approval.policy_resolution_id, remarks: @approval.remarks } }
    end

    assert_redirected_to approval_url(Approval.last)
  end

  test "should show approval" do
    get approval_url(@approval)
    assert_response :success
  end

  test "should get edit" do
    get edit_approval_url(@approval)
    assert_response :success
  end

  test "should update approval" do
    patch approval_url(@approval), params: { approval: { approval_type: @approval.approval_type, approved: @approval.approved, approver_id: @approval.approver_id, policy_resolution_id: @approval.policy_resolution_id, remarks: @approval.remarks } }
    assert_redirected_to approval_url(@approval)
  end

  test "should destroy approval" do
    assert_difference('Approval.count', -1) do
      delete approval_url(@approval)
    end

    assert_redirected_to approvals_url
  end
end
