class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.date :creation_date
      t.integer :amount
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
