class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:post).order(created_at: :desc)
  end

  def new
    @post = Post.find(params[:post_id])
    @transaction = Transaction.new(post: @post, amount: @post.amount)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.status = "completed"
    @transaction.processed_at = Time.current

    # Ensure post is loaded for interest and rendering fallback
    @post = Post.find_by(id: @transaction.post_id)
    @transaction.post = @post if @post

    if @transaction.save
      redirect_to transactions_path, notice: 'Transaction completed successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def transelect
    @posts = Post.where(status: "Approved").order(created_at: :desc)
  end

  def start_transaction
    post_id = params[:post_id]

    if post_id.present? && Post.exists?(post_id)
      redirect_to new_transaction_path(post_id: post_id)
    else
      redirect_to transelect_post_path, alert: "Please select a valid borrower."
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:post_id, :amount)
  end
end
