class CommissionInvoice < ApplicationRecord
  self.table_name = "gipi_comm_invoice"
  self.primary_key = "intrmdry_intm_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :gross_commission, :commission_amt
  alias_attribute :w_tax, :wholding_tax

  belongs_to :policy, foreign_key: :policy_id
  has_one :intermediary, foreign_key: :intm_no
  has_many :premium_collections, foreign_key: :b140_prem_seq_no, primary_key: :prem_seq_no

  def net_commission
    gross_commission - w_tax
  end
  
end
