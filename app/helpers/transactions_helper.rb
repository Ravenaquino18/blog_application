# app/helpers/transactions_helper.rb
module TransactionsHelper
  def format_transaction_status(status)
    case status
    when "completed"
      content_tag(:span, "✔ Completed", class: "badge bg-success")
    when "pending"
      content_tag(:span, "⏳ Pending", class: "badge bg-warning")
    else
      status.to_s
    end
  end
end
