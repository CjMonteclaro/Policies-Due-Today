class PolicyItem < ApplicationRecord

  self.table_name = "gipi_item"
	self.primary_key = "item_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")


	alias_attribute :id, :policy_id
  alias_attribute :no, :item_no
	alias_attribute :title, :item_title
  alias_attribute :description, :item_desc
  alias_attribute :description2, :item_desc2

  belongs_to :policy, foreign_key: :policy_id
  belongs_to :travel, foreign_key: :policy_id
  belongs_to :accident_item, foreign_key: :item_no

	has_many :policy_item_perils , foreign_key: :item_no
	belongs_to :vehicle, foreign_key: :policy_id, primary_key: :policy_id

end
