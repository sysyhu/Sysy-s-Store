class DropUserTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :User
  end
end
