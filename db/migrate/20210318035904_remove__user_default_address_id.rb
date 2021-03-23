class RemoveUserDefaultAddressId < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :default_address_id, :integer
  end
end
