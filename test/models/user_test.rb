require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def setup
      @user = User.new(
                        name: "例得　升男",
                        email: "example@mail.co.jp",
                        employee_number: 12345678,
                        division: "技術部研究開発課",
                        gender: "男",
                        started_at: 1.year.ago,
                        birthday: 24.years.ago,
                        employee: true,
                        password: 'password',
                        password_confirmation: 'password'
                      )
   end

   test "should be valid" do
      assert @user.valid?
   end

   test "name should be present" do
      @user.name = ""
      assert_not @user.valid?
   end

   test "name should be shorter than 20 chars" do
      @user.name = "a" * 21
      assert_not @user.valid?
   end

   test "email should be present" do
      @user.email = ""
      assert_not @user.valid?
   end

   test "email should be shorter than 20 chars" do
      @user.email = ("a" * 255) + "mail.co.jp"
      assert_not @user.valid?
   end

   test "email should have addresses in a proper format" do
     valid_addresses = %w[user@example.com
                          michael@yahoo.co.jp
                          USER@foo.com
                          mon_key+oh@foo.com]
     valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
     end

     invalid_addresses = %w[user@example,com
                          michael_yahoo_co_jp
                          user@name.example.
                          mon_key+oh@foo+.com]
     invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
     end
   end

   test "email should be unique" do
      duplicated_user = @user.dup
      @user.save
      assert_not duplicated_user.valid?
   end

   test "employee_number should be present" do
      @user.employee_number = ""
      assert_not @user.valid?
   end

   test "employee_number should be shorter than 20 chars" do
      @user.employee_number = 123456789
      assert_not @user.valid?
   end

   test "division should be present" do
      @user.division = ""
      assert_not @user.valid?
   end

   test "division should be shorter than 20 chars" do
      @user.division = "a" * 51
      assert_not @user.valid?
   end

   test "gender should be present" do
      @user.gender = ""
      assert_not @user.valid?
   end

   test "gender should be specified word" do
      @user.gender = "両"
      assert_not @user.valid?
   end

   test "started_at should be present" do
      @user.started_at = ""
      assert_not @user.valid?
   end

   test "birthday should be present" do
      @user.birthday = ""
      assert_not @user.valid?
   end

   test "employee should be present" do
      @user.employee = ""
      assert_not @user.valid?
   end

   test "password should be present" do
      @user.password = @user.password_confirmation = ""
      assert_not @user.valid?
   end

   test "password should have more than 8 chars" do
      @user.password = "f" * 7
      assert_not @user.valid?
   end

   test "password should match its expression with the confirmation" do
      @user.password = "drowssap"
      assert_not @user.valid?
      @user.password_confirmation = @user.password
      assert @user.valid?
   end

end
