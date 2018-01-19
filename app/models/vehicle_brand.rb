class VehicleBrand < ApplicationRecord
  self.table_name = "giis_mc_car_company"
	self.primary_key = "car_company_cd"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

	alias_attribute :code, :car_company_cd
	alias_attribute :brand, :car_company

  has_one :vehicle, foreign_key: :policy_id
  belongs_to :policy
end
