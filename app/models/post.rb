class Post < ApplicationRecord
    validates :borrower_name, presence: true, length: { minimum: 5, maximum: 100 }
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :interest_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
    validates :term_months, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 500 }
    validates :start_date, presence: true
    validates :purpose, presence: true, length: { minimum: 10, maximum: 500 }
    belongs_to :user # This line should be here, after all validations

    # Method to calculate the total interest earned for this specific loan
    def total_interest_earned
        # Simple Interest Calculation
        # I = P * R * T
        # P = Principal (amount)
        # R = Annual Interest Rate (interest_rate / 100)
        # T = Time in years (term_months / 12.0)

        # Ensure values are treated as decimals for accurate financial calculations
        principal = self.amount.to_d || 0.0
        annual_rate = (self.interest_rate.to_d || 0.0) / 100.0
        time_in_years = (self.term_months.to_d || 0.0) / 12.0

        interest = principal * annual_rate * time_in_years
        interest.round(2) # Round to two decimal places for currency display
    end

    validate :total_payables_must_be_correct # Keep this line if it's intended to be a custom validation

    def total_payables
        # This method's implementation should be correct as per your logic
        # Example:
        # amount.to_f + (amount.to_f * (interest_rate.to_f / 100)) # This looks like amount + simple interest.
        # You might want to consider the term_months in this calculation too if it represents total repayable.
        # Example:
        # total_amount = self.amount.to_d + self.total_interest_earned
        # total_amount.round(2)
        amount.to_f + (amount.to_f * (interest_rate.to_f / 100))
    end
end