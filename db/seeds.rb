
# 100.times do |i|
#     puts Employee.create(
#         name: "Employee#{i+1}",
#         email: "employee.#{i+1}@expensetracker.com",
#         employment_status: "Active",
#         department: "Department-#{i/2}"
#     ).save
# end

# puts "======================= Employees built ======================="



# Employee.all.each do |employee|
#     puts employee.expense_reports.build(
#         creation_date: Date.today,
#         description: "Dummy Description 1",
#         status: "Submitted for Approval"
#     ).save

#     puts employee.expense_reports.build(
#         creation_date: Date.today,
#         description: "Dummy Description 2",
#         status: "Submitted for Approval"
#     ).save
# end

# puts "======================= Expense Reports built ======================="



# ExpenseReport.all.each do |expense_report|
#     puts expense_report.expenses.build(
#         creation_date: Date.today,
#         amount: 100,
#         description: "Dummy Description 1",
#         status: "Submitted for Approval",
#         invoice_id: 1234
#     ).save
#     puts expense_report.expenses.build(
#         creation_date: Date.today,
#         amount: 500,
#         description: "Dummy Description 2",
#         status: "Rejected",
#         invoice_id: 4321
#     ).save
# end

# puts "======================= Expenses built ======================="



# ExpenseReport.all.each do |expense_report|
#     puts expense_report.comments.build(
#         name: "Employee",
#         description: "Dummy Description of Employee"
#     ).save
#     puts expense_report.comments.build(
#         name: "Admin",
#         description: "Dummy Description of Admin"
#     ).save
# end

# puts "======================= Comments built ======================="



# Employee.all.each do |employee|
#     puts employee.expenses.build(
#         creation_date: Date.today,
#         amount: 10,
#         description: "Dummy Description 11",
#         status: "Submitted for Approval",
#         invoice_id: 12
#     ).save
#     puts employee.expenses.build(
#         creation_date: Date.today,
#         amount: 50,
#         description: "Dummy Description 12",
#         status: "Rejected",
#         invoice_id: 21
#     ).save
# end

# puts "======================= Expenses built ======================="




# ExpenseReport.all.each do |expense_report|
#     expense_report.total_amount = 0
#     expense_report.expenses.all.each do |expense|
#         if expense.status != 'Rejected'
#             expense_report.total_amount += expense.amount
#         end
#     end
#     expense_report.save
# end
