# require 'csv'
class PoliciesController < ApplicationController
  # load_and_authorize_resource
  authorize_resource
  helper_method :sort_column, :sort_direction
  def index
  end

  def due_today
     # @initializer = Policy.where(inception: 1.months.ago..Date.today).order(sort_column + " " + sort_direction).includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments).page(params[:page]).per(10)

     # @policies = @initializer.select {|policy| policy.due_date.present? && policy.due_date == Date.today}

    @policies = Policy.order('policy_id DESC').includes(:assured, [:commission_invoice => :intermediary], :pdc_payments, :policy_invoice, :policy_payments).page(params[:page]).per(10)


      respond_to do |format|
         format.html
         format.csv {
           # @travels_csv = Policy.travel_search_date(@start_date, @end_date)
           send_data @policies.to_csv, filename: "Policies_Due_Today.csv"
            }
         format.xlsx { render xlsx: 'policies/due_today.xlsx.axlsx', filename: "Policies_Due_Today.xlsx"}
         format.pdf do
           pdf = PoliciesDueTodayReport.new(@policies)
           send_data pdf.render, filename: "Policies_Due_Today.pdf", type: "application/pdf"# ,disposition: "inline"
         end
      end
  end

  def show
    @policy = Policy.find(params[:id])
  end

  def details
    @policy = Policy.find(params[:id])
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
  end

  def travel_declarations
  end

  private

  def sort_column
    Policy.column_names.include?(params[:sort]) ? params[:sort] : "incept_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
