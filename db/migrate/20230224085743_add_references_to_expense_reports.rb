class AddReferencesToExpenseReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :expense_reports, :employee, null: false, foreign_key: true
  end
end






