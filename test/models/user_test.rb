require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(name: "user person", email: "thedude@example.com", 
                        password: "foobar", password_confirmation: "foobar")
    end
    
    test "should be valid" do
        assert @user.valid?
    end    
    
    test "name should be present" do
        @user.name = "  "
        assert_not @user.valid?
    end
    
    test "email shoud be present" do
        @user.email = "  "
        assert_not @user.valid?
    end
    
    test "name should not be too long" do
        @user.name = "a" * 51
        assert_not @user.valid?
    end
    
    test "email should not be too long" do
        @user.email = "a" * 244 + "@example.com"
        assert_not @user.valid?
    end
    
    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A-US-ER@foo.bar.org
         first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |ad|
            @user.email = ad
            assert @user.valid?, "#{ad.inspect} should be valid"
        end
    end
    
    test "email validation should reject invalid addresses" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                                 for@bar_baz.com foo@bar+baz.com] 
        invalid_addresses.each do |inv|
            @user.email = inv
            assert_not @user.valid?, "#{inv.inspect} should be invalid"
        end
    end
    
    test "email addresses should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end
    
    test "password should be present" do 
        @user.password = @user.password_confirmation = " " * 6
        assert_not @user.valid?
    end
    
    test "password should have min length" do
        @user.password = @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end
end
