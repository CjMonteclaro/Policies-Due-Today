class PdcPayment < ApplicationRecord
  self.table_name = "giac_pdc_prem_colln"
  self.primary_key = "prem_seq_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :amount, :collection_amt

  belongs_to :policy_invoice, foreign_key: :prem_seq_no
  has_one :pdc_payment_detail, foreign_key: :pdc_id, primary_key: :pdc_id

  has_one :apdc_payment, through: :pdc_payment_detail, foreign_key: :apdc_id
  has_one :bank, through: :pdc_payment_detail, foreign_key: :bank_cd, primary_key: :bank_cd
end
