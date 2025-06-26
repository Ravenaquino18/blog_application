# app/controllers/calculator_controller.rb
class CalculatorController < ApplicationController
  def interest
    # This action just renders the form (implicitly renders views/calculator/interest.html.erb)
    # The view will handle the display of the form and results.
  end

  def calculate_interest
    # Retrieve parameters using the names from your form
    principal = params[:principal].to_d
    annual_rate = params[:rate].to_d
    term_months = params[:term].to_i

    # Basic validation
    if principal <= 0 || annual_rate <= 0 || term_months <= 0
      flash.now[:alert] = "Please enter positive values for all fields."
      render :interest and return # Render the form again with an error
    end

    # Calculate simple interest
    monthly_rate = (annual_rate / 100) / 12
    @calculated_interest = principal * monthly_rate * term_months
    @calculated_total_payable = principal + @calculated_interest

    # Render the 'interest' view again to display the results.
    render :interest
  end

  def penalty
    # This action just renders the penalty form.
  end

  def calculate_penalty
    # Retrieve parameters from the form
    amount_due = params[:amount_due].to_d
    daily_penalty_rate = params[:daily_penalty_rate].to_d
    days_overdue = params[:days_overdue].to_i

    # Basic validation
    if amount_due <= 0 || daily_penalty_rate < 0 || days_overdue < 0
      flash.now[:alert] = "Please enter valid values for all fields."
      render :penalty and return
    end

    # Calculate penalty
    total_penalty = amount_due * (daily_penalty_rate / 100) * days_overdue
    total_amount_with_penalty = amount_due + total_penalty

    # Store the results in an instance variable
    @penalty_results = {
      amount_due: amount_due,
      daily_penalty_rate: daily_penalty_rate,
      days_overdue: days_overdue,
      total_penalty: total_penalty.round(2),
      total_amount_with_penalty: total_amount_with_penalty.round(2)
    }

    # Render the penalty form template again, showing results.
    render :penalty
  end
end