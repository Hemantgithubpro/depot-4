require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    user = User.new(email_address: "to@example.org")

    mail = UserMailer.welcome(user)
    assert_equal "Welcome", mail.subject
    assert_equal [ "to@example.org" ], mail.to
  end
end
