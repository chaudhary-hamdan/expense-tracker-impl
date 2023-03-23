# Preview all emails at http://localhost:3000/rails/mailers/expense_expense_report_status_change_mailer
class ExpenseExpenseReportStatusChangeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/expense_expense_report_status_change_mailer/approved_notification
  def approved_notification
    ExpenseExpenseReportStatusChangeMailer.approved_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/expense_expense_report_status_change_mailer/rejected_notification
  def rejected_notification
    ExpenseExpenseReportStatusChangeMailer.rejected_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/expense_expense_report_status_change_mailer/partially_approved_notification
  def partially_approved_notification
    ExpenseExpenseReportStatusChangeMailer.partially_approved_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/expense_expense_report_status_change_mailer/comment_added_notification
  def comment_added_notification
    ExpenseExpenseReportStatusChangeMailer.comment_added_notification
  end

end
