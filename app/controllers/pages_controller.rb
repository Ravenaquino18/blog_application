class PagesController < ApplicationController
  def home
  end

  def about
    if ActiveRecord::Base.connection.table_exists?(:credit_cards)
      @credit_cards = CreditCard.all
      @credit_card = CreditCard.new
    else
      @credit_cards = []
      @credit_card = nil
    end
  end
end
