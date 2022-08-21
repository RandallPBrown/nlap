class ErrLogsController < ApplicationController
  layout "scaffold"
  before_action :authenticate_user!
  before_action :authorize_admin
  # before_action :authorize_admin, only: [:dashboard]
  before_action :set_err_log, only: [:show, :edit, :update, :destroy]

  # GET /err_logs
  def index
    @err_logs = ErrLog.all
    @err_log = ErrLog.new
  end



  def err_log_breakdown
    @err_logs = ErrLog.all
    err_log_array = Array.new
    @err_logs.each do |err_log| 
      if err_log.user.deleted_at.nil? 
        err_log_array << {
         '': '', 
         'ID': err_log.id,
         'Agent': err_log.user.full_name, 
         'Department': err_log.department.name, 
         'Date': err_log.errdate.strftime('%m/%d/%Y'), 
         'Status': err_log.err_status.statusname
       }
       # else 
      end  
    end 
    respond_to do |format|
      format.html
      format.json {render :json => err_log_array, public: true}
    end
  end

  def modal
    @err_logs_cost_departmental = ErrLog.all.where("department_id = ?", current_user.department.id).where(errdate: Date.today.beginning_of_month...Date.today.end_of_month).sum(:err_cost)
  end

  def dashboard
    # @part = Part.find(params[:id])
    @err_logs_ajax = ErrLog.all
    err_log_array = Array.new
    @err_logs_ajax.each do |err_log| 
      if err_log.user.deleted_at.nil? 
        err_log_array << {
         '': '', 
         'ID': err_log.id,
         'Agent': err_log.user.full_name, 
         'Department': err_log.department.name, 
         'Date': err_log.errdate.strftime('%m/%d/%Y'), 
         'Status': err_log.err_status.statusname
       }
       # else 
      end  
    end 
    @err_log = ErrLog.all
    @approved_by = User.order(:id).where('users.admin = ?', true)
    @err_logs = ErrLog.includes(:err_status).joins(:err_status).where('statusname = ? OR statusname = ?', 'Pending', 'Dispute').order(created_at: :desc, updated_at: :desc)
    @allerrors = ErrLog.all
    @approvedby = User.all.where('users.admin = ?', true).pluck(:first_name, :last_name)
  end

  # GET /err_logs/1
  def show
  end

  # GET /err_logs/new
  def new
    @err_log = ErrLog.new
  end

  # GET /err_logs/1/edit
  def edit
    @err_log_data = {
          'ID': @err_log.id,
          'dispute_response': @err_log.dispute_response, 
          'serviceorder': @err_log.serviceorder, 
          'approved_by': @err_log.approved_by, 
          'err_notes': @err_log.err_notes, 
          'err_cost': @err_log.err_cost, 
          'user_id': @err_log.user_id,
          'user_name': @err_log.user.full_name, 
          'department_id': @err_log.department_id,
          'department_name': @err_log.department.name,
          'errdate': @err_log.errdate, 
          'err_name_id': @err_log.err_name_id, 
          'errdesc': @err_log.errdesc, 
          'err_status_id': @err_log.err_status_id, 
          'err_status_name': @err_log.err_status.statusname,
          'errsubmitby': @err_log.errsubmitby, 
          'dispute': @err_log.dispute, 
          'err_type_id': @err_log.err_type_id
       }
    respond_to do |format|
      format.html
      format.json {render :json => @err_log_data, public: true}
    end
  end

  # POST /err_logs
  def create
    @err_log = ErrLog.new(err_log_params)
    @err_log.department_id = @err_log.user.department_id
    if @err_log.save
      redirect_back(fallback_location: root_path)
      flash[:notice] = 'Error has been logged successfully'
    else
      render :new
    end
  end

  # PATCH/PUT /err_logs/1
  def update
    if @err_log.update(err_log_params)
      redirect_back(fallback_location: root_path)
      flash[:notice] = 'Error has been updated successfully'
    else
      render :edit
    end
  end

  # DELETE /err_logs/1
  def destroy
    @err_log.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = 'Error has been logged successfully'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_err_log
      @err_log = ErrLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def err_log_params
      params.require(:err_log).permit(:dispute_response, :serviceorder, :approved_by, :err_notes, :err_cost, :user_id, :department_id, :errdate, :err_name_id, :errdesc, :err_status_id, :errsubmitby, :dispute, :err_type_id)
    end
end
