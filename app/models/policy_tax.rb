class PolicyTax < ApplicationRecord
  self.table_name = "gipi_inv_tax"
  self.primary_key = "prem_seq_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :id, :tax_cd
  alias_attribute :amount, :tax_amt

  belongs_to :policy_invoice, foreign_key: :prem_seq_no

  def type
    tax_type = case id
    when 1 then "DST"
    when 2 then "NST"
    when 3 then "EVAT"
    when 4 then "PT"
    when 5 then "FST"
    when 6 then "LGT"
    when 7 then "NF"
    when 8 then "OC"
    when 21 then "DI"
    when 22 then "IR"
    when 23 then "SF"
    when 29 then "COCVF"
    end
  end

end
