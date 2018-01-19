class ApdcPayment < ApplicationRecord
  self.table_name = "giac_apdc_payt"
  self.primary_key = "apdc_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :apdc_number, :apdc_no
  alias_attribute :source, :branch_cd
  alias_attribute :prefix, :apdc_pref
  alias_attribute :date, :apdc_date

  belongs_to :pdc_payment_detail, foreign_key: :apdc_id, primary_key: :apdc_id

end
