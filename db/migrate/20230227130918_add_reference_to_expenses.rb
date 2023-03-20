class AddReferenceToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :expenses, :employee, null: true, foreign_key: true
  end
end
