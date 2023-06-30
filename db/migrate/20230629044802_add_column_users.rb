class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :email, :string, null: false
    add_column :users, :password_digest, :string
  end
end
