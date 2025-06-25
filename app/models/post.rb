# app/models/post.rb

class Post < ApplicationRecord
  ##TB Edited: Uncomment the validations if needed and comment other if needed
    #validates :borrower_name, presence: true, length: { minimum: 5, maximum: 100 }
  #validates :amount, presence: true, numericality: { greater_than_or_equal_to: 100 }
  #validates :interest_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
  #validates :term_months, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 500 }
  #validates :start_date, presence: true
  #validates :purpose, presence: true, length: { minimum: 10, maximum: 500 } # Ensure 'purpose' validation is present

  # #YOUR PREFERRED ENUM DEFINITION (string-based values)
  #enum status: { Pending: "Pending", Approved: "Approved", Rejected: "Rejected", Overdue: "Overdue", Completed: "Completed" }

  # Associations
  belongs_to :user, optional: true # Ensure optional: true is there
  has_one_attached :id_image
  has_many :transactions, dependent: :destroy

  # Set default status for new posts.
  #after_initialize :set_default_status, if: :new_record?

  # Method to calculate the total interest earned for this specific loan
  def total_interest_earned
    principal = self.amount.to_d || 0.0
    annual_rate = (self.interest_rate.to_d || 0.0) / 100.0
    time_in_years = (self.term_months.to_d || 0.0) / 12.0

    interest = principal * annual_rate * time_in_years
    interest.round(2)
  end

  # Method to calculate total payables (principal + total interest earned over the term)
  def total_payables
    (self.amount.to_d + self.total_interest_earned).round(2)
  end

  # Check if the loan is overdue
  def overdue?
    # Ensure start_date is a Date object for calculation
    return false unless self.start_date.is_a?(Date) && self.term_months.present?

    # Calculate the expected end date
    expected_end_date = self.start_date + self.term_months.months

    # A loan is overdue if its expected end date is in the past
    # AND its status is not 'Completed' or 'Rejected' (using string values for comparison)
    expected_end_date < Date.current && !['Completed', 'Rejected'].include?(self.status)
  end

  # Scope to easily retrieve overdue loans
  # IMPORTANT: The SQL 'INTERVAL' syntax is for PostgreSQL.
  # For SQLite: .where("DATE(start_date, '+' || term_months || ' months') < DATE('now')")
  # For MySQL: .where("DATE_ADD(start_date, INTERVAL term_months MONTH) < CURDATE()")
  scope :overdue_loans, -> {
    # Querying directly with string values for string-backed enums
    where.not(status: ["Completed", "Rejected"])
         .where("start_date + INTERVAL '1 month' * term_months < ?", Date.current)
  }

  validate :total_payables_must_be_correct

  def total_payables_must_be_correct
    if total_payables < self.amount
      errors.add(:total_payables, "cannot be less than the original loan amount")
    end
  end

  private

  # Set default status for new posts.
  # Use the exact string 'Pending' as defined in your enum.
  def set_default_status
    self.status ||= 'Pending'
  end
end