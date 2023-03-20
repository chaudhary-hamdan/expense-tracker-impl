class ChangeColumnInExpenses < ActiveRecord::Migration[6.0]
  def change
    change_column :expenses, :expense_report_id, :integer, null: false
  end
end
