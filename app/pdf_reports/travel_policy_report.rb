class TravelPolicyReport < Prawn::Document
     def initialize(start_date, end_date)
       super(:page_size => "A4", :page_layout => :landscape, :font => "Times-Roman")
       Prawn::Font::AFM.hide_m17n_warning = true
       font_size 10
       @start_date = start_date.to_date
       @end_date = end_date.to_date + 1.day
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
         font_size(8) {table transaction_rows}
      end

      def transaction_rows
          [["Policy/Endorsement", "Insured", "Birthdate", "Age", "Inception Date", "Expiry Date", "Duration", "Destination", "TSI", "Destination Class",  "Coverage Limit", "EndorsementText"]] +
           Policy.travel_search(@start_date, @end_date).map do |policy|
             ["#{policy.no} / #{policy.endorsement_no}", policy.assured.name,(policy.accident_item.birthdate unless policy.accident_item.nil?),(policy.accident_item.age unless policy.accident_item.nil?), policy.inception, policy.expiry, policy.duration, policy.destination_countries, policy.tsi, policy.destination_class, policy&.coverage, policy.endorsement_text&.text]
       end
     end
   end
