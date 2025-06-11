class Post < ApplicationRecord
    validates :title, presence: true, length: {minumum: 5, maximum: 100 }
    validates :body, presence: true, length: { minimum: 10, maximum: 100 }
end
