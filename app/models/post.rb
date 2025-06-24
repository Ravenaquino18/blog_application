# app/models/post.rb
class Post < ApplicationRecord
    validates :borrower_name, presence: true, length: { minimum: 5, maximum: 100 }
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :interest_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
    validates :term_months, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 500 }
    validates :start_date, presence: true
    validates :purpose, presence: true, length: { minimum: 10, maximum: 500 }
    belongs_to :user

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

    # Keep this line because you want a custom validation
    validate :total_payables_must_be_correct

    # REFINED: Method to calculate total payables (principal + total interest earned over the term)
    def total_payables
        (self.amount.to_d + self.total_interest_earned).round(2)
    end

    # NEW: Define the custom validation method referred to by 'validate :total_payables_must_be_correct'
    def total_payables_must_be_correct
        # Example validation logic:
        # Add an error if the total payables is less than the original loan amount.
        # This should theoretically always be true if interest_rate >= 0, but it demonstrates the structure.
        if total_payables < self.amount
            errors.add(:total_payables, "cannot be less than the original loan amount")
        end

        # You can add more specific or complex business rules here based on your requirements.
        # For example, if there's a hard cap on total repayment:
        # if total_payables > 1_000_000 # Example: if total payables cannot exceed 1,000,000 PHP
        #   errors.add(:total_payables, "exceeds the maximum allowable total repayment")
        # end
    end
end