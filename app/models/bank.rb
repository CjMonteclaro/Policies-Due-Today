class Bank < ApplicationRecord
  self.table_name = "giac_banks"
  self.primary_key = "bank_cd"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :short_name, :bank_sname
  alias_attribute :name, :bank_name

  belongs_to :pdc_payment_detail, foreign_key: :bank_cd, primary_key: :bank_cd
end
