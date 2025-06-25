# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  # skip_before_action :authenticate_user!, only: [:about] # Uncomment if 'about' is public

  def home
    # Your existing dashboard data
    @total_loans = Post.count
    @total_users = User.count
    @highest_loan = Post.order(amount: :desc).first
    @recent_loans = Post.order(created_at: :desc).limit(5)

    # Corrected: Using the enum helper methods with CAPITALIZED names
    @total_pending_loans = Post.Pending.count # Changed from Post.pending
    @total_approved_loans = Post.Approved.count # Changed from Post.approved
    @total_rejected_loans = Post.Rejected.count # Changed from Post.rejected
    @total_overdue_loans = Post.overdue_loans.count # This scope is defined correctly in Post model itself

    # Calculate overall totals for the summary table
    @overall_total_loans = Post.sum(:amount)
    @overall_total_interest = Post.all.sum { |post| post.total_interest_earned }
    @overall_total_payables = Post.all.sum { |post| post.total_payables }

    # Data for Charts (assuming these are correctly configured in your view)
  end

  # Action to handle the /overdues page
  def overdues
    @overdue_posts = Post.overdue_loans.order(start_date: :asc)
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