class AddUserToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :user, foreign_key: true
    # it adds column in orders table, add_column :orders, :user_id, :bigint
    # adds index in orders table for userid, add_index :orders, :user_id
    # adds foreign key to orders table, add_foreign_key :orders, :users

    # add_column :orders, :user_id, :bigint unless column_exists?(:orders, :user_id)
    # add_index :orders, :user_id unless index_exists?(:orders, :user_id)
    # add_foreign_key :orders, :users unless foreign_key_exists?(:orders, :users)
  end
end
