require "test_helper"

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    support_request = SupportRequest.create!(
      email: "chris@somewhere.net",
      subject: "Need help",
      body: "I can't figure out how to check out!!"
    )
    support_request.update!(response: "We're looking into it.")

    mail = SupportRequestMailer.respond(support_request)

    assert_equal "Re: Need help", mail.subject
    assert_equal [ "chris@somewhere.net" ], mail.to
    assert_equal [ "support@example.com" ], mail.from
    assert_match "We're looking into it.", mail.body.encoded
  end
end
