class AddReferencesToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :expenses, :expense_report, null: false, foreign_key: true
  end
end
