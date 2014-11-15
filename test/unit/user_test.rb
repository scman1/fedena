require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class UserTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods  
  
  validate_presence_of :email
  validate_presence_of :role

  context 'a new user' do
    setup do
      @user = build(:admin_user)
    end

    should 'be new record' do
      assert @user.new_record?
    end

    should 'be valid' do
      assert @user.valid?
    end

    should 'not save without any data' do
      assert_invalid User.new
    end

    should 'not save user without username' do
      @user.username = nil
      assert !@user.valid?
    end

    should 'not save without password' do
      @user.password = nil
      assert !@user.valid?
    end

    should 'accept single character usernames' do
      @user.username = 'a'
      assert @user.valid?
    end

    should 'accept single numeric character usernames' do
      @user.username = '1'
      assert @user.valid?
    end

    should 'accept multiple character usernames' do
      @user.username = 'john'
      assert @user.valid?
    end

    should 'accept 20 character usernames' do
      @user.username = 'a'*20
      assert @user.valid?
    end

    should 'not save without username attribute' do
      @user.username = nil
      assert !@user.valid?
      assert @user.errors[:username].any?
    end

    should 'not accept empty username' do
      @user.username = ''
      assert !@user.valid?
      assert @user.errors[:username].any?
    end

    should 'not accept spl characters in username' do
      usernames = ["O'Hara", 'jack=', 'a&&*']
      usernames.each do |username|
        @user.username = username
        assert !@user.valid?
        assert @user.errors[:username].any?
      end
    end

    should 'not accept spaces in username' do
      @user.username = 'john doe'
      assert !@user.valid?
      assert @user.errors[:username].any?
    end

    should 'not accept 21 character usernames' do
      @user.username = 'a'*21
      assert !@user.valid?
      assert @user.errors[:username].any?
    end

    should 'not accept empty password on create' do
      @user.password = ''
      assert !@user.valid?
      assert @user.errors[:password].any?
    end

    should 'not accept nil as password' do
      @user.password = nil
      assert !@user.valid?
      assert @user.errors[:password].any?
    end

    should 'accept alphanumerics and spl characters in passwords' do
      passwords = ['password', 'pass1', 's!@#$', '12345']
      passwords.each do |password|
        @user.password = password
        assert @user.valid?
      end
    end

    should 'accept valid email addresses' do
      emails = ["nithin@gmail.com", "info@projectfedena.org"]
      emails.each do |email|
        @user.email = email
        assert @user.valid?
      end
    end

    should 'not accept invalid passwords' do
      passwords = [nil, '', 'asd']
      passwords.each do |password|
        @user.password = password
        assert !@user.valid?
      end
    end

    should 'not accept invalid email addresses' do
      emails = ["blah", "b lah"]
      emails.each do |email|
        @user.email = email
        assert !@user.valid?
      end
    end
  end

  context 'with admin user present' do
    setup do
      @admin_user = create(:admin_user, :username => 'admin1')
      @new_user   = build(:admin_user, :username => 'john')
    end

    should 'setup a valid saved user' do
      assert @admin_user.valid?
      assert ! @admin_user.new_record?
    end

    should 'setup a valid unsaved user' do
      assert @new_user.valid?
    end

    should 'have a saved admin user record' do
      assert User.first.admin
      assert_equal User.first.username, 'admin'
    end

    should 'not save with duplicate username' do
      @new_user.username = 'admin'
      assert !@new_user.valid?
    end

    should 'return correct role name for admin' do
      assert_equal @admin_user.role_name, 'Admin'
    end

    should 'return admin role symbol' do
      assert @admin_user.role_symbols.include?(:admin)
      assert_equal @admin_user.role_symbols.length, 1
    end

  end

  private
  def assert_invalid(object, msg = 'object is valid where it should be invalid')
    assert ! object.valid?, msg
  end
  
end