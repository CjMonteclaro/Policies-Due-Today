class User < ApplicationRecord
  octopus_establish_connection(:adapter => "mysql2", :database => "fgen_test", :host => "localhost", :port => "3306", :username => "root", :password => "fortune")
  # octopus_establish_connection(:adapter => "mysql2", :database => ENV['RDS_DB_NAME'], :host => ENV['RDS_HOSTNAME'], :port => ENV['RDS_PORT'], :username => ENV['RDS_USERNAME'], :password => ENV['RDS_PASSWORD'])

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]


  has_one :profile, dependent: :destroy, foreign_key: :user_id#, primary_key: :user_id
  has_one :rank, through: :profile#, foreign_key: :rank_id
  accepts_nested_attributes_for :profile

  has_many :policy_resolutions

  has_many :approvals, class_name: 'Approval', foreign_key: 'approver_id'

  has_one :user_role
  has_many :roles, through: :user_role
  # has_many :approvers, through: :approvals

  # ROLES = %i[admin user]
  #
  # def roles=(roles)
  #   roles = [*roles].map { |r| r.to_sym }
  #   self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  # end
  #
  # def roles
  #   ROLES.reject do |r|
  #     ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
  #   end
  # end
  #
  # def has_role?(role)
  #   roles.include?(role)
  # end

  # def has_role?(role_sym)
  #   roles.any? { |r| r.name.underscore.to_sym == role_sym }
  # end
  def to_s
    username
  end

  def has_role?(role)
    roles.map { |role| role.name }.include? role
  end


  def login=(login)
  @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end


end
