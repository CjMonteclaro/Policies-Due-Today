class Profile < ApplicationRecord
  octopus_establish_connection(:adapter => "mysql2", :database => "fgen_test", :host => "localhost", :port => "3306", :username => "root", :password => "fortune")
  # octopus_establish_connection(:adapter => "mysql2", :database => ENV['RDS_DB_NAME'], :host => ENV['RDS_HOSTNAME'], :port => ENV['RDS_PORT'], :username => ENV['RDS_USERNAME'], :password => ENV['RDS_PASSWORD'])

  belongs_to :user, optional: true#, foreign_key: :id#, primary_key: :user_id
  belongs_to :rank, optional: true#, foreign_key: :rank_id
  # belongs_to :account, foreign_key: :user_id

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile_rank
    case self.rank_id
      when 1..5
        return profile_rank = 'High'
      when 6
        return profile_rank = 'Medium'
      when 7
        return profile_rank = 'Regular'
    end
  end

end
