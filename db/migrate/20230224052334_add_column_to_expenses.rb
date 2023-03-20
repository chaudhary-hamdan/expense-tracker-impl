class AddColumnToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :invoice_id, :integer
  end
end
