class PolicyInvoice < ApplicationRecord
  self.table_name = "gipi_invoice"
  self.primary_key = "prem_seq_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :net_premium, :prem_amt
  alias_attribute :total_taxes, :tax_amt

  belongs_to :policy, foreign_key: :policy_id
  has_many :policy_taxes, foreign_key: :prem_seq_no
  has_many :policy_payments, foreign_key: :prem_seq_no

  has_many :pdc_payments, foreign_key: :prem_seq_no
  has_many :pdc_payment_details, through: :pdc_payment, foreign_key: :prem_seq_no

  def gross_premium
    net_premium + total_taxes
  end

end
