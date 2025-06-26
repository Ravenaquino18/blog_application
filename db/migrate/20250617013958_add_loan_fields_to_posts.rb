class AddLoanFieldsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :borrower_name, :string
    add_column :posts, :amount, :decimal
    add_column :posts, :interest_rate, :decimal
    add_column :posts, :term_months, :integer
    add_column :posts, :start_date, :date
    add_column :posts, :purpose, :text
  end
end
