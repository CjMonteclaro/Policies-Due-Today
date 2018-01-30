require 'csv'
class Policy < ApplicationRecord
  self.table_name = "gipi_polbasic"
  self.primary_key = "policy_id"
  octopus_establish_connection(:adapter => "oracle_enhanced", :database => "FGIC", :host => "172.16.110.241", :port => "1521", :username => "CPI", :password => "CPI12345!")

  alias_attribute :id, :policy_id
  alias_attribute :inception, :incept_date
  alias_attribute :expiry, :expiry_date
  alias_attribute :effectivity, :eff_date
  alias_attribute :issued, :issue_date
  alias_attribute :source, :iss_cd
  alias_attribute :sequence_no, :pol_seq_no
  alias_attribute :tsi, :tsi_amt

  belongs_to :assured, foreign_key: :assd_no

  has_one :commission_invoice, foreign_key: :policy_id
  has_one :intermediary, through: :commission_invoice, foreign_key: :intm_no

  has_one :policy_info, foreign_key: :policy_id
	has_one :accident_item, foreign_key: :policy_id
  belongs_to :assured, foreign_key: :assd_no

  has_one :policy_invoice, foreign_key: :policy_id
  has_many :policy_taxes, through: :policy_invoice, foreign_key: :prem_seq_no

  has_one :endorsement_text, foreign_key: :policy_id
  has_many :policy_items, foreign_key: :policy_id

  has_many :premium_collections, through: :commission_invoice, foreign_key: :prem_seq_no

  has_many :policy_payments, through: :policy_invoice, foreign_key: :prem_seq_no
  has_many :pdc_payments, through: :policy_invoice, foreign_key: :prem_seq_no

	has_many :policy_item_perils, foreign_key: :policy_id
	has_many :perils, through: :policy_item_perils, foreign_key: :peril_cd

  belongs_to :vehicle, foreign_key: :policy_id
	has_one :vehicle_body_type, through: :vehicle, foreign_key: :policy_id
	has_one :vehicle_brand, through: :vehicle, foreign_key: :policy_id

  ransacker :due_date, type: :date do
    Arel.sql('date(date_due)')
  end

  scope :not_spoiled, -> { where.not(pol_flag: [4,5]) }
  scope :travel_eager_load, -> { includes(:assured, :policy_items, :policy_info, :endorsement_text, :accident_item) }

  scope :check_odth, -> { joins(:perils).where('PERIL_CD = ?', 46) }
  scope :not_trucks, -> { joins(:vehicle_body_type, :vehicle).where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%TRUCK%', '%TRUCK%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%FREEZER%', '%FREEZER%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%CARGO%', '%CARGO%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%ALUMINUM%', '%ALUMINUM%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%CANTER%', '%CANTER%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%DROPSIDE%', '%DROPSIDE%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%ELF%', '%ELF%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%Elf%', '%Elf%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%ALUM%', '%ALUM%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%TRAILER%', '%TRAILER%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%TRACTOR%', '%TRACTOR%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%TANK%', '%TANK%').where.not('TYPE_OF_BODY LIKE ? OR MAKE LIKE ?', '%SKELETAL%', '%SKELETAL%')}

  scope :motor_eager_load, -> { includes(:policy_items, :vehicle, :vehicle_brand, :vehicle_body_type) }
  scope :private_vehicles, -> { where(subline_cd: ["PC","CV"])   }

  ##########
  # FOR POLICIES DUE TODAY
  ##########

  def no
    "#{line_cd}-#{subline_cd}-#{source}-#{issue_yy}-#{proper_seq_no}-#{proper_renew_number}"
  end

  def endorsement_no
    basic = "#{endt_iss_cd}-#{endt_yy}-#{endorsement_sequence}"
    endorsement_type = "-#{endt_type}" if endt_type?
    endorsement_no = basic + endorsement_type if endt_seq_no?
  end

  def not_endorsement?
    self.endorsement_sequence.to_i == 0
  end

  def proper_seq_no
    sprintf '%07d', sequence_no
  end

	def proper_renew_number
    sprintf '%02d', renew_no
	end

  def endorsement_sequence
    sprintf '%07d', endt_seq_no
  end

  def net_due
    policy_invoice.gross_premium - commission_invoice.net_commission if policy_invoice && commission_invoice
  end

  def due_date
    due_date = effectivity + intermediary.credit_term if commission_invoice
    return due_date
  end

  def self.to_csv
		attributes = %w{Policy_No Endorsement_No Insured Intermediary Inception_Date Expiry_Date Effective_date Premium_Amount}
		CSV.generate(headers: true) do |csv|
			csv << attributes

			  Policy.where(inception: 1.months.ago..Date.today).includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments).each do |policy|
				csv << [policy.no, policy.endorsement_no,policy.assured.name, policy.intermediary&.name, policy.incept_date, policy.expiry_date, policy.eff_date, policy.prem_amt]
			end
		end
  end

  ##########
  # FOR MOTOR DECLARATION
  ##########

  def self.motors_search(start_date, end_date)
		self.where(issued: start_date..end_date).private_vehicles.not_spoiled.check_odth.not_trucks.motor_eager_load
    #.order('subline_cd,iss_cd,pol_seq_no,renew_no')
	end

  def self.motor_to_csv(motor_policies)
    attributes = %w{PolicyNo Endorsement ContactNo Address IssueDate EffectiveDate ExpiryDate Vehicle PlateNo Color SerialNo MotorNo PerilName SumInsured Premium PremiumRate}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      motor_policies.each do |policy|
				policy.perils.where(line_cd: "MC").find_each do |peril|

            csv << [policy.no, policy.endorsement_no, policy&.assured.address, policy&.assured.phone_no, policy.issued, policy.effectivity, policy.expiry, policy.vehicle&.vehicle_name, policy.vehicle&.plate_no, policy.vehicle&.color, policy.vehicle&.serial_no, policy.vehicle&.motor_no ]
				end
      end
    end
  end

  def address
    "#{self.address1} #{self.address2} #{self.address3}"
  end

  ##########
  # FOR TRAVEL PA
  ##########

  def self.travel_search(start_date,end_date)
    where(issued: start_date..end_date, line_cd: 'PA', subline_cd: 'TPS').not_spoiled.travel_eager_load
  end

  def duration
    (self.expiry - self.effectivity).to_i + 1
  end

  def destination_countries
    if policy_info&.present? && policy_info&.general_info1.present? && policy_info&.general_info1["-"]
      policy_info.general_info1
    elsif accident_item&.destination.present? && accident_item&.destination["-"]
      accident_item&.destination
    else
      "NOT INDICATED"
    end
  end

  def destination_class
    if accident_item&.destination_class.present?
      accident_item&.destination_class
    elsif policy_info&.travel_class.present?
      policy_info&.travel_class
    else
      "Not Indicated"
    end
  end

  def coverage
		if self.policy_info&.travel_class.nil? || policy_info&.travel_class.blank?
			case self.accident_item&.destination_class
				when "SCHENGEN","schengen"
					then "50,000"
				when "WORLDWIDE","worldwide","WORLD WIDE"
					then "50,000"
				when "ASIAN","asian"
					then "20,000"
				else "Not Specified"
			end
		else
			case self.policy_info&.travel_class
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

  def self.travel_csv(travel_policies)
		attributes = %w{Policy/Endorsement Insured Birthday Age Inception ExpiryDate Duration Destination TSI DestinationClass CoverageLimit EndorsementText TotalPayment}
		CSV.generate(headers: true) do |csv|
			csv << attributes

			travel_policies.each do |policy|
        policy.policy_payments.where(iss_cd: policy.iss_cd).each do |payment|

				  csv << ["#{policy.no} - #{policy.endorsement_no}", policy.assured.name,(policy.accident_item.birthdate unless policy.accident_item.nil?),(policy.accident_item.age unless policy.accident_item.nil?), policy.inception, policy.expiry, policy.duration, policy.destination_countries, policy.tsi, policy.destination_class, policy&.coverage, policy.endorsement_text&.text, payment.total_payment]
        end
			end
		end
	end

end
