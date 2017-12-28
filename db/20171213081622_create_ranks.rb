class CreateRanks < ActiveRecord::Migration[5.1]
    using(:shard_two)
  def change
    create_table :ranks do |t|
      t.string :name
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
