class TransactionsController < ApplicationController
  before_action :set_post, only: [:new, :create]

  def index
    @transactions = Transaction.includes(:post).order(processed_at: :desc)
  end

  def new
    @transaction = @post.transactions.new
  end

  def create
    @transaction = @post.transactions.build(transaction_params)
    @transaction.processed_at = Time.current
    @transaction.status = "Disbursed"

    if @transaction.save
      redirect_to transactions_path, notice: "Transaction processed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end
