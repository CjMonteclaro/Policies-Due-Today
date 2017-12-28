class CreateRoles < ActiveRecord::Migration[5.1]
  using(:shard_two)
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
