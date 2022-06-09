class RemoveUniqEmailOnDb < ActiveRecord::Migration[6.1]
  reversible do |dir|
    dir.up do
      remove_index :guests, :email
      add_index :guests, :email
    end

    dir.down do
      remove_index :guests, :email
      add_index :guests, :email, unique: true
    end
  end
end
