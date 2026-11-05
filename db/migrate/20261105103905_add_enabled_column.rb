class AddEnabledColumn < ActiveRecord::Migration[8.1]
  def change
    # add_column(table_name, column_name, data_type, options)
    add_column :products, :enabled, :boolean
    add_column :products, :discount_price, :decimal, default: 0
    add_column :products, :permalink, :string
  end
end
