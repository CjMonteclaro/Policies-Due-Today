class PaymentReversal < ApplicationRecord
  self.table_name = "giac_reversals"
  self.primary_key = "gacc_tran_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :id, :gacc_tran_id

end
