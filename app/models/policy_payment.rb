class PolicyPayment < ApplicationRecord
  self.table_name = "giac_aging_soa_details"
  self.primary_key = "prem_seq_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")



  alias_attribute :installment, :inst_no
  alias_attribute :total_payment, :total_payments
  alias_attribute :balance_due, :balance_amt_due

  belongs_to :policy_invoice, foreign_key: :prem_seq_no

end
