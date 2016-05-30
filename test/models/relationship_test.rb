require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should required a follower_id" do
      @relationship.follower_id = nil
      assert_not @relationship.valid?
  end

  test "should required a followed_id" do
      @relationship.followed_id = nil
      assert_not @relationship.valid?
  end
end
