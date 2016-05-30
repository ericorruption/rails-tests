require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @user = users(:archer)
    @other_user = users(:anderson)
  end

  test "index paginates" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index has delete links and deletes when logged in as admin" do
    log_in_as(@admin)
    get users_path
    User.paginate(page: 1).each do |user|
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index has no delete links when logged in as non-admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index shows only activated users" do
    log_in_as(@user)
    get users_path
    assert_select 'a[href=?]', user_path(@other_user), count: 0
  end
end
