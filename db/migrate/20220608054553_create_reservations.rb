class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code
      t.references :guest, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :nights_quota
      t.integer :adults_amount
      t.integer :children_amount
      t.integer :infants_amount
      t.string :status
      t.string :currency
      t.decimal :security_price, precision: 8, scale: 2
      t.decimal :payout_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
