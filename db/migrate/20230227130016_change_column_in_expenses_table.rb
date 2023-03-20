class ChangeColumnInExpensesTable < ActiveRecord::Migration[6.0]
  def change
    change_column :expenses, :expense_report_id, :integer, null: true
  end
end
