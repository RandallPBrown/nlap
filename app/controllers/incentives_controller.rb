class IncentivesController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin
  before_action :authenticate_user!
  before_action :set_incentive, only: [:show, :edit, :update, :destroy]

  # GET /incentives
  def index
    @incentives = Incentive.all.joins(:user)
  end

  def dashboard
  end

  def incentive_breakdown
    @incentives = Incentive.all
    incentive_array = Array.new
    @incentives.each do |incentive| 
      if incentive.user.deleted_at.nil? 
        incentive_array << {'User': incentive.user.full_name, 
         'Occurrences': incentive.user.agent.entries.effective.joins(:occurrence).sum(:ovalue), 
         'Uph': incentive.uph, 
         'Errors': ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where('user_id = ?', incentive.user_id).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').where(errdate: incentive.date).count, 
         'Occupancy': incentive.occupancy, 
         'Turntime': incentive.turntime, 
         'Contracts': incentive.contracts, 
         'AHT': incentive.aht,
         'Date': incentive.date.strftime("%m/%d/%Y"),
         '': (helpers.link_to(helpers.theme_icon_tag('eye'), incentive, 'data-toggle': 'tooltip', title: 'Show', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('pencil-alt'), edit_incentive_path(incentive), 'data-toggle': 'tooltip', title: 'Edit', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('trash'), incentive, 'data-toggle': 'tooltip', title: 'Delete', method: :delete, class: 'btn btn-link p-1'))}
       else 
      end  
    end 
    respond_to do |format|
      format.html
      format.json {render :json => incentive_array, public: true}
    end
  end

  def incentive_dashboard_breakdown
    @incentives = User.all.joins(:incentives).where('incentives.date': Date.today.beginning_of_month..Date.today.end_of_month).group(:id)
    incentive_array = Array.new
    @incentives.each do |user| 
      if user.deleted_at.nil? 
        incentive_array << {'User': helpers.link_to(user.full_name, incentives_incentive_dashboard_breakdown_pdf_path(:id => user.id, format: :pdf), class: 'btn btn-link p-1'),
         'Occurrences': user.agent.entries.effective.joins(:occurrence).sum(:ovalue), 
         'Uph': user.incentives.average(:uph), 
         'Errors': ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where('user_id = ?', user.id).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').count, 
         'Occupancy': user.incentives.average(:occupancy), 
         'Turntime': user.incentives.average(:turntime), 
         'Contracts': user.incentives.sum(:contracts), 
         'AHT': user.incentives.average(:aht),
         '': (helpers.link_to(helpers.theme_icon_tag('eye'), user, 'data-toggle': 'tooltip', title: 'Show', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('pencil-alt'), edit_incentive_path(user), 'data-toggle': 'tooltip', title: 'Edit', class: 'btn btn-link p-1') + " " + helpers.link_to(helpers.theme_icon_tag('trash'), user, 'data-toggle': 'tooltip', title: 'Delete', method: :delete, class: 'btn btn-link p-1'))}
       else 
      end  
    end 
    respond_to do |format|
      format.html
      format.json {render :json => incentive_array, public: true}
    end
  end

  def incentive_dashboard_breakdown_pdf

    @user = User.find(params[:id])
    @incentives = Incentive.all.where('user_id = ?', @user.id).order(date: :desc).where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @entries = Entry.all.joins(:occurrence, agent: :user).where('user_id = ?', @user.id).order(edate: :desc).where(edate: 90.days.ago..Date.today)
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "Breakdown-#{current_user.full_name}-#{Date.today}"
      end
    end
  end

  def import
    @errors = ErrLog.joins(:err_status, :err_name).includes(:err_status, :err_name).where('user_id = ?', current_user.id).select(:err_names).where('err_names.errname = ?', 'Improvement Opportunity').where(errdate: Date.current.beginning_of_month...Date.today).count
      csv_file = params[:file].read
      CSV.parse(csv_file) do |row|
      incentives = Incentive.create(user_id: row[0], uph: row[1], occupancy: row[2], date: row[3], aht: row[4], turntime: row[5], contracts: row[7])
      incentives.save
    end
    redirect_to incentives_path, notice: "Queue added"
  end

  # GET /incentives/1
  def show
  end

  # GET /incentives/new
  def new
    @incentive = Incentive.new
  end

  # GET /incentives/1/edit
  def edit
  end

  # POST /incentives
  def create
    @incentive = Incentive.new(incentive_params)

    if @incentive.save
      redirect_to @incentive, notice: 'Incentive was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /incentives/1
  def update
    if @incentive.update(incentive_params)
      redirect_to @incentive, notice: 'Incentive was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /incentives/1
  def destroy
    @incentive.destroy
    redirect_to incentives_url, notice: 'Incentive was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incentive
      @incentive = Incentive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def incentive_params
      params.require(:incentive).permit(:user_id, :uph, :quality, :improvement_opp, :occupancy, :turntime, :contracts, :aht, :date)
    end
end
