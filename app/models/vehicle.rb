class Vehicle < ApplicationRecord
  self.table_name = "gipi_vehicle"
	self.primary_key = "policy_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

	alias_attribute :id, :policy_id
	alias_attribute :item_number, :item_no
  alias_attribute :modelyear, :model_year

  has_one :policy_item, foreign_key: :policy_id, primary_key: :policy_id

  has_one :policy, foreign_key: :policy_id
  belongs_to :vehicle_body_type, foreign_key: :type_of_body_cd
  belongs_to :vehicle_brand, foreign_key: :car_company_cd

  def vehicle_name
      "#{self.modelyear} - #{self.vehicle_brand&.brand} - #{self.make} - #{self.vehicle_body_type&.body_type}"
  end
end
