class ExpenseExpenseReportStatusChangeMailer < ApplicationMailer

  def approved_notification
    mail to: 'chamdan387@gmail.com', subject: "Approved"
  end

  def rejected_notification
    mail to: 'chamdan387@gmail.com', subject: "Rejected"
  end

  def partially_approved_notification
    mail to: 'chamdan387@gmail.com', subject: "Partially Approved"
  end

  def comment_added_notification
    mail to: 'chamdan387@gmail.com', subject: "Comment Added"
  end
end
