class PartsController < ApplicationController
  layout "scaffold"
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:dashboard]
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  # GET /parts
  def index
    require 'will_paginate/array'
    if params[:search].present?
      @parts = Part.order(created_at: :desc, updated_at: :desc).perform_search(params[:search]).order(params[:sort]).paginate(page: params[:page], :per_page => 10)
    else
      @parts = Part.all.order(created_at: :desc, updated_at: :desc)
    end
    @approvedby = User.all.where('users.admin = ?', true).pluck(:first_name, :last_name)
    @pending = Part.where('parts.covered = ?', 'pending')
    @pendinguser = Part.order(updated_at: :desc).where('parts.covered = ?', 'pending').where('parts.submitted_by = ?', current_user.full_name).paginate(page: params[:page], :per_page => 5)
    @alluser = Part.order(updated_at: :desc).where(:read_at => nil).where('parts.submitted_by = ?', current_user.full_name).paginate(page: params[:page], :per_page => 5)
  end

  def dashboard
    require 'will_paginate/array'
    # @part = Part.find(params[:id])
    @approved_by = User.order(:id).where('users.admin = ?', true)
    @parts = Part.all.where('parts.covered = ?', 'pending').order(created_at: :desc, updated_at: :desc).paginate(page: params[:page], :per_page => 5)
    @allparts = Part.all
    @approvedby = User.all.where('users.admin = ?', true).pluck(:first_name, :last_name)
  end

  # GET /parts/1
  def show
  @pending_parts = Part.find(params[:id])
  if @pending_parts.submitted_by == current_user.full_name
    @pending_parts.read_at = Time.now
    @pending_parts.save
  end
  end

  # GET /parts/new
  def new
    @part = Part.new
    @product = Product.new
    @buying_group = BuyingGroup.new
    if params[:search].present?
      @parts = Part.perform_search(params[:search]).order(params[:sort]).paginate(page: params[:page], :per_page => 5)
    else
      @parts = Part.all
    end
  end

  # GET /parts/1/edit
  def edit
    @approvedby = User.all.where('users.admin = ?', true)
  end

  # POST /parts
  def create
    @part = Part.new(part_params)

    if @part.save
      redirect_to parts_path, notice: 'Part was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parts/1
  def update
    if @part.update(part_params)
      redirect_to parts_path, notice: 'Part was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /parts/1
  def destroy
    @part.destroy
    redirect_to parts_dashboard_path, notice: 'Part was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def part_params
      params.require(:part).permit(:part_number, :part_name, :part_description, :product_id, :buying_group_id, :dop, :covered, :submitted_by, :approved_by, :source, :note)
    end
end
