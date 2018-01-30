class PoliciesController < ApplicationController
  # load_and_authorize_resource
  authorize_resource
  helper_method :sort_column, :sort_direction


  def index
    @policies = Policy.order('GET_POLICY_NO(POLICY_ID) ASC').page(params[:page]).per(100)
  end

  def show
    @policy = Policy.find(params[:id])
    @policies = Policy.where(line_cd: @policy.line_cd , subline_cd: @policy.subline_cd , iss_cd: @policy.source , issue_yy: @policy.issue_yy , pol_seq_no: @policy.sequence_no , renew_no: @policy.renew_no)
  end

  def due_today

     @due = Policy.search(params[:q])
     @policies = @due.result.includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments).page(params[:page]).per(10)
     # @initializer = Policy.where(inception: 1.months.ago..Date.today).includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments)

     # @policies =  Kaminari.paginate_array(@initializer.reject {|policy| policy.due_date != Date.today}).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data @initializer.to_csv, filename: "Policies_Due_Today.csv" }
      format.xlsx { render xlsx: 'policies/due_today.xlsx.axlsx', filename: "Policies_Due_Today.xlsx"}
      format.pdf do
         pdf = PoliciesDueTodayReport.new(@initializer)
         send_data pdf.render, filename: "Policies_Due_Today.pdf", type: "application/pdf"
      end
    end
  end

  def motor_declarations
    detect_date_params
    @initializer = Policy.motors_search(@start_date, @end_date)
    @motor_policies = @initializer.page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.csv { send_data Policy.motor_to_csv(@initializer), filename: "motorcar-#{@start_date} #{@end_date}.csv" }
      format.xlsx { render xlsx: 'policies/motor_declarations.xlsx.axlsx', filename: "Motor Car Declaration #{@start_date} #{@end_date}.xlsx"}
      format.pdf do
        pdf = MotorsReport.new(@initializer)
        send_data pdf.render,filename: "MotorCar.pdf", type: "application/pdf"
      end
    end
  end

  def travel_declarations
    detect_date_params
    @initializer = Policy.travel_search(@start_date, @end_date)
    @travel_policies = @initializer.page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.csv { send_data Policy.travel_csv(@initializer), filename: "travelpa-#{@start_date}/#{@end_date}.csv" }
      format.xlsx { render xlsx: 'policies/travel_declarations.xlsx.axlsx', filename: "Travel PA Declaration -#{@start_date}/#{@end_date}.xlsx" }
      format.pdf do
        pdf = TravelPolicyReport.new(@start_date, @end_date)
        send_data pdf.render, filename: "TravelPA.pdf", type: "application/pdf"# ,disposition: "inline"
      end
    end
  end

  private

  def detect_date_params
    if params[:start_date].present?
      @start_date = params[:start_date]
      @end_date =  params[:end_date]
    else
      @start_date =  Date.current.beginning_of_month
      @end_date =  Date.current.end_of_month
    end
  end

end
