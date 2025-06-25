class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :post, null: false, foreign_key: true
      t.decimal :amount
      t.string :status
      t.datetime :processed_at

      t.timestamps
    end
  end
end
