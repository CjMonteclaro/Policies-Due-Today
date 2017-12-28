class CreatePolicyResolutions < ActiveRecord::Migration[5.1]
  using(:shard_two)
  def change
    create_table :policy_resolutions do |t|
      t.integer :user_id #also prepared_by
      t.integer :policy_id
      t.string :policy_no
      t.string :endt_no
      t.integer :assured_id
      t.integer :intermediary_id
      t.string :intermediary_name
      t.integer :credit_term
      t.string :request_type #extension, cancellation, reinstatement
      t.date :orig_due
      t.integer :extension
      t.date :new_due
      t.decimal :premium_due
      t.string :payment_type
      t.decimal :payment_amount, precision: 10, scale: 2
      t.date :payment
      t.date :effective_date
      t.date :cancelled
      t.date :reinstated
      t.date :effective_date
      t.text :remarks

      t.timestamps
    end
  end
end
