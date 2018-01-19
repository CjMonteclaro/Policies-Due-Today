class AccidentItem < ApplicationRecord

    self.table_name = "gipi_accident_item"
  	self.primary_key = "policy_id"
    octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")


  	alias_attribute :pol_id, :policy_id
  	alias_attribute :item_number, :item_no
  	alias_attribute :birthdate, :date_of_birth

  	has_one :policy_item, foreign_key: :item_no
  	belongs_to :policy, foreign_key: :policy_id
    belongs_to :travel, foreign_key: :policy_id

	def destination_class
		/schengen|worldwide|asian/i.match(destination).to_s
	end

end
