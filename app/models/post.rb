class Post < ApplicationRecord
    validates :borrowers_name, presence: true, length: {minumum: 5, maximum: 100 }
    validates :amount, presence: true, length: { minimum: 10, maximum: 100 }
    belongs_to :user
end
