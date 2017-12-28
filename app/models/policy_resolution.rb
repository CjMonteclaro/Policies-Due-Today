class PolicyResolution < ApplicationRecord
  octopus_establish_connection(:adapter => "mysql2", :database => "fgen_test", :host => "localhost", :port => "3306", :username => "root", :password => "fortune")
  # octopus_establish_connection(:adapter => "mysql2", :database => ENV['RDS_DB_NAME'], :host => ENV['RDS_HOSTNAME'], :port => ENV['RDS_PORT'], :username => ENV['RDS_USERNAME'], :password => ENV['RDS_PASSWORD'])

  has_many :approvals
  belongs_to :user, optional: true

  before_save :compute_new_due_date, if: :extension?

  def compute_new_due_date
    self.new_due = orig_due + extension
  end


end
