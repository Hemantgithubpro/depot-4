class ChangeEnabledDefault < ActiveRecord::Migration[8.1]
  def change
    change_column :products, :enabled, :boolean, default: false
  end
end
