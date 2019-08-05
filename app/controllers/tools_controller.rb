class ToolsController < ApplicationController
 layout "scaffold"
 skip_before_action :verify_authenticity_token
 force_ssl except: :validator

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

  def validator_email
  	@tool = Tool.new(validator_params)
  	# @tool.receipt = :receipt
  	@tool.save
  	if @tool.save
  		@recipient = Recipient.all
     	@recipient.each do |recipient|
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

    def validator_params
      params.permit(:username, :receipt, :serviceorder, :caller_name, :service_provider, :model_number, :serial_number, :failure_cause, :warranty_link, :sku, :opp, :ppc, :lol, :distributor, :total_parts, :total_labor, :total_tax, :total_mileage, :total_misc, :total_deductible, :total_estimate, :approved, :diagnostic, :asdf)
    end
end
