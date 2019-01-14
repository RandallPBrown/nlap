class DepartmentsController < ApplicationController
  layout "scaffold"
  before_action :authorize_admin
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  def index
    if current_user.has_role?(:supervisor) || current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @departments = Department.all
    else
      puts 'Unauthorized'
    end
  end

  # GET /departments/1
  def show
  end

  # GET /departments/new
  def new
    if current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @department = Department.new
    else
      redirect_to departments_path, notice: 'Unauthorized'
    end
  end

  # GET /departments/1/edit
  def edit
    if current_user.has_role?(:director) || current_user.has_role?(:executive) then

    else
      redirect_to departments_path, notice: 'Unauthorized'
    end
  end

  # POST /departments
  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to @department, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /departments/1
  def update
    if @department.update(department_params)
      redirect_to @department, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /departments/1
  def destroy
    if current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @department.destroy
      redirect_to departments_url, notice: 'Department was successfully destroyed.'
    else
      redirect_to departments_path, notice: 'Unauthorized'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params.require(:department).permit(:id, :name, :desc, :foreign_key)
    end
end
