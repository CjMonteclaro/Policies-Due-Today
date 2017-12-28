class PdcPaymentDetail < ApplicationRecord
  self.table_name = "giac_apdc_payt_dtl"
  self.primary_key = "pdc_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :amount, :check_amt
  alias_attribute :number, :check_no
  alias_attribute :date, :check_date

  belongs_to :pdc_payment, foreign_key: :pdc_id, primary_key: :pdc_id

  has_one :apdc_payment, foreign_key: :apdc_id, primary_key: :apdc_id
  has_one :bank, foreign_key: :bank_cd, primary_key: :bank_cd
end
