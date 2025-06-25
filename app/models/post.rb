class Post < ApplicationRecord

    belongs_to :user
    has_one_attached :id_image
    has_many :transactions, dependent: :destroy
end
