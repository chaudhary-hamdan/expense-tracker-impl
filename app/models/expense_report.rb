class ExpenseReport < ApplicationRecord
    belongs_to :employee
    has_many :expenses, dependent: :delete_all
    has_many :comments, dependent: :delete_all
    validates :creation_date, :total_amount, :description, :status, presence: true
end
