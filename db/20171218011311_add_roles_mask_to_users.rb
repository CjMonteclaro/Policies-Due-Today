class AddRolesMaskToUsers < ActiveRecord::Migration[5.1]
    using(:shard_two)
  def change
    add_column :users, :roles_mask, :integer
  end
end
