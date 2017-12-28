class CreateUsers < ActiveRecord::Migration[5.1]
    using(:shard_two)
  def change
    create_table :users do |t|
      t.string :username

      t.timestamps
    end
  end
end
