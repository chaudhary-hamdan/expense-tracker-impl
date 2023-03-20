class CreateExpenseReports < ActiveRecord::Migration[6.0]
  def change
    create_table :expense_reports do |t|
      t.integer :total_amount

      t.timestamps
    end
  end
end
