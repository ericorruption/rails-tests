require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
      @user = users(:michael)
      @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", full_title("Sign up")
  end

  test "edit should redirect home when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "update should redirect home when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "edit should redirect when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "update should redirect when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
