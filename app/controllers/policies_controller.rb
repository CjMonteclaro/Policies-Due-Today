class PoliciesController < ApplicationController
  # load_and_authorize_resource
  authorize_resource
  helper_method :sort_column, :sort_direction
  def index
  end

  def due_today
     @initializer = Policy.where(inception: 1.months.ago..Date.today).order(sort_column + " " + sort_direction).includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments)

     @policies =  Kaminari.paginate_array(@initializer.reject {|policy| policy.due_date != Date.today}).page(params[:page]).per(10)

      respond_to do |format|
         format.html
         format.csv {
           # @travels_csv = Policy.travel_search_date(@start_date, @end_date)
           send_data @initializer.to_csv, filename: "Policies_Due_Today.csv"
            }
         format.xlsx { render xlsx: 'policies/due_today.xlsx.axlsx', filename: "Policies_Due_Today.xlsx"}
         format.pdf do
           pdf = PoliciesDueTodayReport.new(@initializer)
           send_data pdf.render, filename: "Policies_Due_Today.pdf", type: "application/pdf"# ,disposition: "inline"
         end
      end
  end

  def index
    @policies = Policy.order('GET_POLICY_NO(POLICY_ID) ASC').page(params[:page]).per(100)
  end

  def show
    @policy = Policy.find(params[:id])
  end

  def details
    @policy = Policy.find(params[:id])
    @policies = Policy.where(line_cd: @policy.line_cd , subline_cd: @policy.subline_cd , iss_cd: @policy.source , issue_yy: @policy.issue_yy , pol_seq_no: @policy.sequence_no , renew_no: @policy.renew_no)

  end

  def new
    @policy = Policy.find(params[:id])
    # @policy_extension = PolicyExtension.new
  end

  def create
    # @policy_extension = PolicyExtension.new(policy_extension_params)

    respond_to do |format|
      if @policy_extension.save
        format.html { redirect_to @policy_extension, notice: 'Policy extension was successfully created.' }
        format.json { render :show, status: :created, location: @policy_extension }
      else
        format.html { render :new }
        format.json { render json: @policy_extension.errors, status: :unprocessable_entity }
      end
    end
  end

  def motor_declarations
    detect_date_params
    @motor_policies = Policy.motors_search(@start_date, @end_date).page(params[:page]).per(20)

    respond_to do |format|
    format.html
    format.csv { send_data Policy.motor_to_csv(@start_date,@end_date), filename: "motorcar-#{@start_date} #{@end_date}.csv" }
    format.xlsx
      format.pdf do
         pdf = MotorsReport.new(@start_date, @end_date)
         send_data pdf.render,filename: "MotorCar.pdf", type: "application/pdf"
         end
     end
  end

  def travel_declarations
    detect_date_params
    @travel_policies = Policy.travel_search(@start_date, @end_date).page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.csv {
        detect_date_params
        # @travels_csv = Policy.travel_search_date(@start_date, @end_date)
        send_data Policy.travel_csv(@start_date, @end_date), filename: "travelpa-#{@start_date}/#{@end_date}.csv"
        }
      format.xlsx
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

  def sort_column
    Policy.column_names.include?(params[:sort]) ? params[:sort] : "incept_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
