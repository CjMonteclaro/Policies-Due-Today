class VehicleBodyType < ApplicationRecord
  self.table_name = "giis_type_of_body"
	self.primary_key = "type_of_body_cd"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

	alias_attribute :code, :type_of_body_cd
	alias_attribute :body_type, :type_of_body

  has_one :vehicle, foreign_key: :policy_id
  belongs_to :policy
end
