class EndorsementText < ApplicationRecord
  self.table_name = "gipi_endttext"
	self.primary_key = "policy_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

	alias_attribute :id, :policy_id
  alias_attribute :text, :endt_text01

  belongs_to :policy, foreign_key: :policy_id
  belongs_to :travel, foreign_key: :policy_id

end
