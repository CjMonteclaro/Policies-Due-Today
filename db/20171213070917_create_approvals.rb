class CreateApprovals < ActiveRecord::Migration[5.1]
  using(:shard_two)
  def change
    create_table :approvals do |t|
      t.references :policy_resolution, foreign_key: true
      t.string :approval_type
      t.integer :approver_id
      t.date :approved
      t.text :remarks

      t.timestamps
    end
  end
end
