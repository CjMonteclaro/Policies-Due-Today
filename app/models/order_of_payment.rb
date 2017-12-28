class OrderOfPayment < ApplicationRecord
  self.table_name = "giac_order_of_payts"
  self.primary_key = "gacc_tran_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :id, :gacc_tran_id

  belongs_to :account_transaction, foreign_key: :tran_id
  belongs_to :premium_collection, foreign_key: :gacc_tran_id

end
