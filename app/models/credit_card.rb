class CreditCard < ApplicationRecord
  def last4
    number.to_s.last(4)
  end
end