class AccountTransaction < ApplicationRecord
  self.table_name = "giac_acctrans"
  self.primary_key = "tran_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :id, :tran_id
  alias_attribute :journal_voucher, :jv_no

  has_many :order_of_payments, foreign_key: :gacc_tran_id
  belongs_to :premium_collection
  
end
