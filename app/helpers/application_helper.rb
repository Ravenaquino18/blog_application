module ApplicationHelper
  # Format number as Philippine Peso (₱1,000.00)
  def number_to_peso(amount, precision: 2)
    number_to_currency(
      amount,
      unit: "₱",
      format: "%u%n",        # Currency symbol before the number
      separator: ".",        # Decimal separator
      delimiter: ",",        # Thousands delimiter
      precision: precision   # Number of decimal places (default 2)
    )
  end
end
