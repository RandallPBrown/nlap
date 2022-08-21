class ToolsController < ApplicationController
 layout "scaffold"

  before_action :set_tool, only: [:show, :edit, :update, :destroy]

  # GET /tools
  def index
    
    @tools = Tool.all
  end

  # GET /tools/1
  def show
  end

  def speed_test
    @procedure = Procedure.all
    @section = Section.all.order(item: :asc)
  end

  def procedure_view
    @section = Section.all
  end

  # GET /tools/new
  def new
    @tool = Tool.new
  end

  def validator

  end

  def pendingreview
    @product = Product.new
    @products = Product.all
    @buying_group = BuyingGroup.new
    @buying_groups = BuyingGroup.all
    @dealer = Dealer.new
    @dealers = Dealer.all
    @contact = Contact.new
    @contacts = Contact.all
  end

  def get_dealer
    submitted_code = params[:submitted_code]
    asdf = Dealer.where("dealer.id = ")
    
    # do something with submitted_code and return the results
    if params[:submitted_code].present?
      @dealer_code = Dealer.all.find_by(code: submitted_code)
      @contacts = Contact.all.joins(:dealer).where("dealer_id = ?", @dealer_code.id)
      @emails = Contact.all.joins(:dealer).where("dealer_id = ?", @dealer_code.id).where("priority = ?", "Primary")
    else
      @dealer_code = " "
      @contacts = " "
    end
    respond_to do |format|
      format.html
      format.json {render :json => [@dealer_code.to_json(:include => :buying_group),@contacts.order(priority: :asc),@emails]}
    end
  end

  def ferguson
    @fergusons = Ferguson.all.where("user_id = ?", current_user.id)
    ferguson_array = Array.new
    @fergusons.each do |ferg|
      ferguson_array << {
          'District': ferg.district.name,
          'Service Order': ferg.so_number,
          'Customer': ferg.customer_name.truncate(15),
          'Provider': ferg.sp_name.truncate(15),
          'Address': ferg.address.truncate(15),
          'Manufacturer': ferg.manufacturer.truncate(15),
          'Product': ferg.product,
          'Escalated': helpers.best_in_place(ferg, :escalated, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light', :confirm => 'Has the customer escalated?'),
          'Leaking': helpers.best_in_place(ferg, :leaking, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light', :confirm => 'Has the unit started leaking?'),
          'FO - C': helpers.best_in_place(ferg, :customer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light', :confirm => 'Have you contacted the customer?'),
          'FO - SP': helpers.best_in_place(ferg, :servicer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light', :confirm => 'Confirmed dispatch with Service Provider?'),
          'FO - D': helpers.best_in_place(ferg, :dealer_fo, as: :checkbox, collection: {false: helpers.fa_icon_tag("times-circle text-danger"), true: helpers.fa_icon_tag("check-circle text-success")}, :class => 'border rounded p-1 bg-light', :confirm => 'Informed Ferguson location of dispatch?')
        }
    end
    respond_to do |format|
      format.html
      format.json {render :json => ferguson_array}
    end
  end

  def manufacturer_check
    submitted_code = params[:submitted_code]
    mfg_warranties = MfgWarranty.where("model_number = ")
    
    # do something with submitted_code and return the results
    if params[:submitted_code].present?
      @mfg_code = MfgWarranty.all.find_by(model_number: submitted_code)
    else
      @mfg_code = " "
    end
    respond_to do |format|
      format.html
      format.json {render :json => @mfg_code}
    end
  end

  def get_district
    submitted_code = params[:submitted_code]
    
    if params[:submitted_code].present?
      @district_code = District.all.find_by(name: submitted_code)
    else
      @district_code = " "
    end
    respond_to do |format|
      format.html
      format.json {render :json => @district_code.to_json}
    end
  end

  def validator_email
  	@tool = Tool.new(validator_params)
  	# @tool.receipt = :receipt
    @recipient = Recipient.all.joins(:recipient_group).group(:id).where('description = ?', 'Tools').references(:recipient_groups)
  	if @tool.save
  		@recipient.joins(:recipient_group).group(:id).each do |recipient|
            ToolMailer.tool_email(@tool, recipient).deliver_now
        end
    end
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools
  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      redirect_to @tool, notice: 'Tool was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tools/1
  def update
    if @tool.update(tool_params)
      redirect_to @tool, notice: 'Tool was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tools/1
  def destroy
    @tool.destroy
    redirect_to tools_url, notice: 'Tool was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tool_params
      params.require(:tool).permit(:receipt)
    end

    def ferguson_params
      params.permit(:user_id, :district_id, :so_number, :customer_name, :sp_name, :address, :manufacturer, :product, :model, :escalated, :leaking, :customer_fo, :servicer_fo, :dealer_fo)
    end

    def validator_params
      params.permit(:username, :receipt, :serviceorder, :caller_name, :service_provider, :model_number, :serial_number, :failure_cause, :warranty_link, :sku, :opp, :ppc, :lol, :distributor, :total_parts, :total_labor, :total_tax, :total_mileage, :total_misc, :total_deductible, :total_estimate, :approved, :diagnostic, :asdf)
    end
end
