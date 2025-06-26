class Post < ApplicationRecord
    validates :borrower_name, presence: true, length: { minimum: 5, maximum: 100 }
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :interest_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
    validates :term_months, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 500 }
    validates :start_date, presence: true
    belongs_to :user
    enum loan_type: { personal: 0, business: 1, student: 2 }
    validates :loan_type, presence: true
    enum status: { Pending: "Pending", Approved: "Approved", Rejected: "Rejected" }
    has_one_attached :id_image
    has_many :transactions, dependent: :destroy
end
