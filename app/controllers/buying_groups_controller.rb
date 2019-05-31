class BuyingGroupsController < ApplicationController
  layout "scaffold"

  before_action :set_buying_group, only: [:show, :edit, :update, :destroy]

  # GET /buying_groups
  def index
    @buying_groups = BuyingGroup.all
  end

  # GET /buying_groups/1
  def show
  end

  # GET /buying_groups/new
  def new
    @buying_group = BuyingGroup.new
  end

  # GET /buying_groups/1/edit
  def edit
  end

  # POST /buying_groups
  def create
    @buying_group = BuyingGroup.new(buying_group_params)

    if @buying_group.save
      redirect_to new_part_path, notice: 'Buying group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /buying_groups/1
  def update
    if @buying_group.update(buying_group_params)
      redirect_to @buying_group, notice: 'Buying group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /buying_groups/1
  def destroy
    @buying_group.destroy
    redirect_to buying_groups_url, notice: 'Buying group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buying_group
      @buying_group = BuyingGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def buying_group_params
      params.require(:buying_group).permit(:bgname, :id)
    end
end
