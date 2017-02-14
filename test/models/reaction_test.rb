require 'test_helper'

class ReactionTest < ActiveSupport::TestCase

   def setup
      @employee = users(:employee)
      @noon = posts(:noon)
      @reaction = Reaction.new(
                              user_id: @employee.id,
                              post_id: @noon.id
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

   test "should be unique or should not react to the same post" do
      @reaction.save
      @duplicated_reaction = Reaction.new(
                                          user_id: @employee.id,
                                          post_id: @noon.id
                                          )
      assert_not @duplicated_reaction.valid?
   end

   test "reaction should be destroyed when relative user deleted" do
      @employee.destroy
      assert_equal 0, @employee.reactions.count
   end

   test "reaction should be destroyed when relative post deleted" do
      @noon.destroy
      assert_equal 0, @noon.reactions.count
   end

end
