module ApplicationHelper
    def number_to_peso(amount)
        number_to_currency(amount, unit: "₱", format: "%u%n", separator: ".", delimiter: "," , precision: 2)
      
    end
end
