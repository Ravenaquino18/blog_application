class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[edit update destroy]

  def index
    @credit_cards = CreditCard.all
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_card_params)
    if @credit_card.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to about_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("credit_card_form", partial: "credit_cards/form", locals: { credit_card: @credit_card }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("credit_card_form", partial: "credit_cards/form", locals: { credit_card: @credit_card }) }
      format.html
    end
  end

  def update
    if @credit_card.update(credit_card_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to about_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("credit_card_form", partial: "credit_cards/form", locals: { credit_card: @credit_card }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @credit_card.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to about_path }
    end
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  end

  def credit_card_params
    params.require(:credit_card).permit(:name, :number, :expiry)
  end
end