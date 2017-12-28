class CreateProfiles < ActiveRecord::Migration[5.1]
  using(:shard_two)

   def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :department # underwriting, accounting, MIS, claims
      t.integer :rank_id # president, chairman, vp, svp, avp, supervisor, manager, regular user, admin
      t.date :effectivity
      t.date :deactivation

      t.timestamps
    end
  end
end
