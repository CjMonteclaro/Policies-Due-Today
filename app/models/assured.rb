class Assured < ApplicationRecord
  self.table_name = "giis_assured"
  self.primary_key = "assd_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FTEST", :host => "172.16.110.31", :port => "1521", :username => "CPI", :password => "CPI12345!")


  alias_attribute :id, :assd_no
  alias_attribute :name, :assd_name

  has_many :policies, foreign_key: :assd_no

  def to_s
    name
  end
end
