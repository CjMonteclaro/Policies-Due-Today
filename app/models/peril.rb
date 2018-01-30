class Peril < ApplicationRecord
  self.table_name = "giis_peril"
  self.primary_key = "peril_cd"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :shortname, :peril_sname
  alias_attribute :name, :peril_name

  has_one :policy_item_peril, foreign_key: :peril_cd
  has_many :policies, through: :policy_item_peril, foreign_key: :policy_id
end
