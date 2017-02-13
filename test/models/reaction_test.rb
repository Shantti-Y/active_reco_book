require 'test_helper'

class ReactionTest < ActiveSupport::TestCase

   def setup
      @employee = users(:employee)
      @morning = posts(:morning)
      @reaction = Reaction.new(
                              user_id: @employee.id,
                              post_id: @morning.id
                              )
   end

   test "should be valid" do
      assert @reaction.valid?
   end

   test "user id should be present" do
      @reaction.user_id = ""
      assert_not @reaction.valid?
   end

   test "post id should be present" do
      @reaction.post_id = ""
      assert_not @reaction.valid?
   end

   test "reaction should be destroyed when relative user deleted" do
      @employee.destroy
      assert_equal 0, @employee.reactions.count
   end

   test "reaction should be destroyed when relative post deleted" do
      @morning.destroy
      assert_equal 0, @morning.reactions.count
   end

end
