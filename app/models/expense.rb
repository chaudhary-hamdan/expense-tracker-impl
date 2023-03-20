class Expense < ApplicationRecord

    belongs_to :employee, optional: true
    belongs_to :expense_report, optional: true

    has_one_attached :invoice_image
    validates :invoice_id, :creation_date, :amount, :description, presence: true

end
