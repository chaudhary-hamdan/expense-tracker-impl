require 'test_helper'

class ExpenseExpenseReportStatusChangeMailerTest < ActionMailer::TestCase
  test "approved_notification" do
    mail = ExpenseExpenseReportStatusChangeMailer.approved_notification
    assert_equal "Approved notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "rejected_notification" do
    mail = ExpenseExpenseReportStatusChangeMailer.rejected_notification
    assert_equal "Rejected notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "partially_approved_notification" do
    mail = ExpenseExpenseReportStatusChangeMailer.partially_approved_notification
    assert_equal "Partially approved notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "comment_added_notification" do
    mail = ExpenseExpenseReportStatusChangeMailer.comment_added_notification
    assert_equal "Comment added notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
