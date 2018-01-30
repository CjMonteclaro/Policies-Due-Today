class MotorsReport < Prawn::Document
  def initialize(motor_policies)
    super(:page_size => "A4", :page_layout => :landscape, :font => "Times-Roman")
    Prawn::Font::AFM.hide_m17n_warning = true
    font_size 8
    @motor_policies = motor_policies
    render_header
    render_body
  end

  private

  def render_header
    filename = "#{Rails.root}/app/assets/fgen.jpg"
    image filename, :width => 250, :height => 50, :position => :left
  end

  def render_body
    move_down 20
    font_size 8
    table transaction_rows
  end

  def transaction_rows

   [["Policy No", "Endorsement", "Address", "Contact No", "Issue Date", "Effective Date" , "Expiry Date", "Vehicle", "Plate No", "Color", "Serial No", "Motor No ", "Peril Name", "Sum Insured", "Premium", "Premium Rate"]] +

    @motor_policies.map do |policy|
      policy.perils&.where(line_cd: "MC").each do |peril|
        policy.policy_item_perils&.where(peril_cd: peril).each do |item|
          # subtable = make_table([[peril&.shortname],[item&.tsi], [item&.prem], [item&.rate]]).to_s

          # [policy.no, policy.endorsement_no, policy&.assured.address, policy&.assured.phone_no, policy.issued, policy.effectivity, policy.expiry, policy.vehicle&.vehicle_name, policy.vehicle&.plate_no, policy.vehicle&.color, policy.vehicle&.serial_no, policy.vehicle&.motor_no, subtable.to_s ]
          [policy.no, policy.endorsement_no, policy&.assured.address, policy&.assured.phone_no, policy.issued, policy.effectivity, policy.expiry, policy.vehicle&.vehicle_name, policy.vehicle&.plate_no, policy.vehicle&.color, policy.vehicle&.serial_no, policy.vehicle&.motor_no, peril.shortname, item&.tsi, item&.prem, item.rate ] #
        end
      end
    end

  end


end
