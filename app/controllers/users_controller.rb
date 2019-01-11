class UsersController < ApplicationController
  layout 'scaffold'
  before_action :authorize_admin, except: [:show, :dashboard, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def dashboard          
    # @body_class = "with-sidebar show-sidebar"
    # @current_user = current_user
    @user_entry = Entry.ue.paginate(page: params[:page], :per_page => 3)
    @user_entry_today = Entry.today.ue
    @user_entry_effective = Entry.effective.ue
    @user_entry_total_effective = Entry.effective.uete
    @user_entry_tardy_effective = Entry.effective.uete2
    @user_entry_absent_effective = Entry.effective.ueae
  	@agent_chart_labels = Entry.effective.acl
  	@agent_chart_data = Entry.effective.acd
    @user_writeup_written = Dap.written.uww
    @user_dap = Dap.joins(:writeup, :user).where("users.id = ?", current_user.id).group(:id).order("daps.ddate DESC").paginate(page: params[:page], :per_page => 3)
  require 'will_paginate/array'
  end

  def show
  end

  # GET /agents/new
  def new
    if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
      @user = User.new
    else
      redirect_to agents_path, notice: 'Unauthorized'
    end
  #  @departments = Department.new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  def create
      @user = User.new(user_params)
      if @user.save
        # UserMailer.welcome_email(@user).deliver_now
        redirect_to agents_path, notice: 'User was successfully created.'
        Agent.create({:department_id => @user.department_id, :user_id => @user.id})
      else
        render :new
      end
  end

  # PATCH/PUT /agents/1
  def update
    if @user.update_without_password(user_params)
      Agent.where("user_id = ?", @user.id).update({:department_id => @user.department_id, :user_id => @user.id})
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end



def destroy
  # DELETE /resource
  if current_user.has_role?(:manager) || current_user.has_role?(:director) || current_user.has_role?(:executive) then
    @user.soft_delete
    # Devise.sign_out_all_scopes ? sign_out : sign_out(@user)
    # set_flash_message :notice, :destroyed
    yield @user if block_given?
    # respond_with_navigational(@user){ redirect_to agents_path(@user.id) }

  # @user.destroy!
  redirect_to agents_path, notice: 'User was successfully destroyed.'
  else
    redirect_to agents_path, notice: 'Unauthorized'
  end
end

  def index
    @users = User.all.includes(:daps, agent: :entries).joins(agent: :entries).order('users.first_name asc')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :first_name, :last_name, :email, :department_id, :password, :password_confirmation, :department, :agent)
    end
end
