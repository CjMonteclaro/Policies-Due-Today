class PolicyResolutionsController < ApplicationController
  authorize_resource
  before_action :set_policy_resolution, only: [:show, :edit, :update, :destroy]

  # GET /policy_resolutions
  # GET /policy_resolutions.json
  def index
    @policy_resolutions = PolicyResolution.all.order('id DESC').page(params[:page]).per(10)
  end

  # GET /policy_resolutions/1
  # GET /policy_resolutions/1.json
  def show
    @approval = @policy_resolution.approvals.build
  end

  # GET /policy_resolutions/new
  def new
    @policy = Policy.find(params[:id])
    @policy_resolution = PolicyResolution.new
  end

  # GET /policy_resolutions/1/edit
  def edit
    @policy = Policy.find(params[:genweb_id])
  end

  # POST /policy_resolutions
  # POST /policy_resolutions.json
  def create
    @policy_resolution = PolicyResolution.new(policy_resolution_params)

    respond_to do |format|
      if current_user.policy_resolutions << @policy_resolution
        format.html { redirect_to @policy_resolution, notice: 'Policy resolution was successfully created.' }
        format.json { render :show, status: :created, location: @policy_resolution }
      else
        format.html { render :new }
        format.json { render json: @policy_resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policy_resolutions/1
  # PATCH/PUT /policy_resolutions/1.json
  def update
    respond_to do |format|
      if @policy_resolution.update(policy_resolution_params)
        format.html { redirect_to @policy_resolution, notice: 'Policy resolution was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy_resolution }
      else
        format.html { render :edit }
        format.json { render json: @policy_resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_resolutions/1
  # DELETE /policy_resolutions/1.json
  def destroy
    @policy_resolution.destroy
    respond_to do |format|
      format.html { redirect_to policy_resolutions_url, notice: 'Policy resolution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy_resolution
      @policy_resolution = PolicyResolution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_resolution_params
      params.require(:policy_resolution).permit(:policy_id ,:policy_no, :endt_no, :user_id, :assured_id, :intermediary_id, :intermediary_name, :effective_date, :premium_due, :credit_term, :request_type, :orig_due, :extension, :new_due, :payment_type, :payment_amount, :payment, :cancelled, :reinstated, :remarks)
    end
end
