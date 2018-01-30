class PolicyInfo < ApplicationRecord

	self.table_name = "gipi_polgenin"
	self.primary_key = "policy_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

	alias_attribute :id, :policy_id
	alias_attribute :general_info, :gen_info
	alias_attribute :general_info1, :gen_info01
	alias_attribute :initial_inf, :initial_info01

	belongs_to :policy, foreign_key: :policy_id
  belongs_to :travel, foreign_key: :policy_id

	def travel_class
		/schengen|worldwide|asian/i.match(general_info1).to_s
	end

	def coverage
		case travel_class
			when "SCHENGEN","schengen"
				then "50,000"
			when "WORLDWIDE","worldwide","WORLD WIDE"
				then "50,000"
			when "ASIAN","asian"
				then "20,000"
			else "Not Specified"
		end
	end

end
