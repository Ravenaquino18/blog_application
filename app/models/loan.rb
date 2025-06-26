class Loan < ApplicationRecord
  enum loan_type: { personal: 0, business: 1, student: 2 }
  validates :borrower_name, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: true
end
