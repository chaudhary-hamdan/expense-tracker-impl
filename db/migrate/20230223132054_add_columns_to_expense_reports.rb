class AddColumnsToExpenseReports < ActiveRecord::Migration[6.0]
  def change
    add_column :expense_reports, :creation_date, :date
    add_column :expense_reports, :description, :text
    add_column :expense_reports, :status, :string
  end
end
