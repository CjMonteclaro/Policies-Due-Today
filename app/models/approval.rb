class Approval < ApplicationRecord
  # octopus_establish_connection(:adapter => "mysql2", :database => ENV['RDS_DB_NAME'], :host => ENV['RDS_HOSTNAME'], :port => ENV['RDS_PORT'], :username => ENV['RDS_USERNAME'], :password => ENV['RDS_PASSWORD'])
  octopus_establish_connection(:adapter => "mysql2", :database => "fgen_test", :host => "localhost", :port => "3306", :username => "root", :password => "fortune")

  belongs_to :policy_resolution, optional: true
  belongs_to :approver, class_name: 'User', foreign_key: "approver_id", optional: true
end
