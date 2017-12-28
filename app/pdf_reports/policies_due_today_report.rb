class PoliciesDueTodayReport < Prawn::Document
     def initialize(policies)
       super(:page_size => "A4", :page_layout => :landscape, :font => "Times-Roman")
       font_size 10
       render_header
       render_body
      end

      private

      def render_header
       filename = "#{Rails.root}/public/fgen.jpg"
       image filename, :width => 500, :height => 70, :position => :left
      end

      def render_body
         move_down 20
         font_size(8) {table transaction_rows}
      end

      def transaction_rows
          [["Policy_No", "Endorsement_No", "Insured", "Intermediary", "Inception_Date", "Expiry_Date", "Effective_date", "Premium_Amount"]] +
          Policy.order('policy_id DESC').limit(10).includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments).map do |policy|
             [policy.no, policy.endorsement_no,policy.assured.name, policy.intermediary&.name, policy.incept_date, policy.expiry_date, policy.eff_date, policy.prem_amt]
       end
     end
   end
