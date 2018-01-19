class MotorsReport < Prawn::Document
    def initialize(start_date, end_date)
      super(:page_size => "A4", :page_layout => :landscape, :font => "Times-Roman")
      Prawn::Font::AFM.hide_m17n_warning = true
      font_size 8
      @start_date = start_date
      @end_date = end_date
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
        font_size(8) {table transaction_rows }
     end

    def transaction_rows
         [["Policy No:", "Endorsement", "Issue Date", "Effective Date" , "Expiry Date", "Vehicle", "Peril Name", "Sum Insured", "Premium", "Premium Rate"]] +
      Policy.motors_search(@start_date, @end_date).map do |policy|

        policy.perils&.where(line_cd: "MC").each do |peril|
          policy.policy_item_perils&.where(peril_cd: peril).each do |item|
            # subtable = make_table([[peril&.shortname],[item&.tsi], [item&.prem], [item&.rate]])
            # [l&.no, l&.endorsement_no, l&.issued, l&.effectivity, l&.expiry, l.vehicle&.vehicle_name, subtable ].to_s
            [policy.no, policy&.endorsement_no, policy.issued, policy.effectivity, policy.expiry, policy.vehicle&.vehicle_name, peril.shortname, item&.tsi, item&.prem, item.rate ]
          end
        end
      end
    end

    
    end
