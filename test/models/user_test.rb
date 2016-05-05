require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "user passwords must match" do
    u = User.new(password: "dog", password_confirmation: "cat")
    assert_not u.valid?
    assert_includes u.errors.keys, :password_confirmation
  end

  test "can authenticate known users" do
    suze = users(:suze)
    assert_equal suze, User.log_in(suze.email, "password")
  end

  test "won't authenticate mismatched data" do
    assert_not User.log_in("x", "y")
  end

  test "won't authenticate a known user with a bad password" do
    suze = users(:suze)
    assert_not User.log_in(suze.email, "catdog")
  end
end
