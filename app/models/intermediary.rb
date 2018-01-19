class Intermediary < ApplicationRecord
  self.table_name = "giis_intermediary"
  self.primary_key = "intm_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")




  alias_attribute :name, :intm_name
  alias_attribute :type, :intm_type

  has_many :commission_invoices, foreign_key: :intrmdry_intm_no
  has_many :policies, through: :commission_invoices, foreign_key: :policy_id

  def credit_term
    if self.type == "BR"
      90
    else
      30
    end
    #
    # case type
    # when "BR" then 90
    # when "OA" then 60
    # when "SP" then 30
    # else 30
    # end
  end

end
