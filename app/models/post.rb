class Post < ApplicationRecord
    validates :borrower_name, presence: true, length: { minimum: 5, maximum: 100 }
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :interest_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
    validates :term_months, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 500 }
    validates :start_date, presence: true
    validates :purpose, presence: true, length: { minimum: 10, maximum: 500 }

    belongs_to :user
end
