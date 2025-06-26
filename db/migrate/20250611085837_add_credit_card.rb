class AddCreditCard < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :number
      t.string :expiry

      t.timestamps
    end
  end
end
