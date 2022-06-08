class CreateGuestPhones < ActiveRecord::Migration[6.1]
  def change
    create_table :guest_phones do |t|
      t.string :number
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
