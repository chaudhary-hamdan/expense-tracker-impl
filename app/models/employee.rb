class Employee < ApplicationRecord
    
    has_many :expense_reports, dependent: :delete_all
    has_many :expenses, dependent: :delete_all

    validates :name, :email, :department, presence: true
    validates :email, uniqueness: true

end
