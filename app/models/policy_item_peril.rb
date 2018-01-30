class PolicyItemPeril < ApplicationRecord

  self.table_name = "gipi_itmperil"
  self.primary_key = "item_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :pol_id, :policy_id
  alias_attribute :itm_no, :item_no
  alias_attribute :rate, :prem_rt
  alias_attribute :tsi, :tsi_amt
  alias_attribute :prem, :prem_amt

  belongs_to :policy, foreign_key: :policy_id
  belongs_to :policy_item, foreign_key: :item_no
  belongs_to :peril, foreign_key: :peril_cd

  def peril_shortname(object)
    Peril.where(line_cd: object)
  end

  def find_peril
    Peril.where(line_cd: self.line_cd, peril_cd: self.peril_cd).first
  end

end
