class Assured < ApplicationRecord
  self.table_name = "giis_assured"
  self.primary_key = "assd_no"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :id, :assd_no
  alias_attribute :name, :assd_name
  alias_attribute :address1, :mail_addr1
  alias_attribute :address2, :mail_addr2
  alias_attribute :address3, :mail_addr3

  has_many :policies, foreign_key: :assd_no

  ransacker :name, formatter: proc { |v| v.mb_chars.upcase.to_s } do |parent|
    Arel::Nodes::NamedFunction.new('UPPER',[parent.table[:assd_name]])
  end

  def to_s
    name
  end

  def address
    "#{address1} #{address2} #{address3}"
  end
end
