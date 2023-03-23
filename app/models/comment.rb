class Comment < ApplicationRecord
    belongs_to :expense_report
    
    validates :name, :description, presence: true
end
