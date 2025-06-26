class AddLoanTypeToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :loan_type, :string
  end
end
