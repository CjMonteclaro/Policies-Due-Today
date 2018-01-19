class PremiumCollection < ApplicationRecord
  self.table_name = "giac_direct_prem_collns"
  self.primary_key = "gacc_tran_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :id, :gacc_tran_id
  alias_attribute :premium, :premium_amt
  alias_attribute :tax, :tax_amt
  alias_attribute :issue_code, :b140_iss_cd
  alias_attribute :sequence_no, :b140_prem_seq_no

  has_many :account_transactions, foreign_key: :tran_id
  has_many :order_of_payments, foreign_key: :gacc_tran_id
  belongs_to :commission_invoice, foreign_key: :prem_seq_no, primary_key: :prem_seq_no


end
