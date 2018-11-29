class EntriesController < ApplicationController
  layout "scaffold"

  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def dashboard        
    
    @body_class = "with-sidebar show-sidebar"
    @entries = Entry.all.includes(occurrence: params[:ovalue])
    @occurrenceval = Entry.all.map {|m| m.occurrence}
    @occurrencecalc = @occurrenceval.map.sum{|n| n.ovalue}
    # @dv1 = Entry.all.map {|d| d.agent}
    # @dv2 = @dv1.map {|k| k.department}
    # @dv3 = @dv2.map {|l| l.id}
    # @departmentname = @departmentval.map{|f| f.department}
    # @ed = Entry.order(@dv3).all.map {|g| g.occurrence}
    @chart = @occurrenceval.map{|n| n.ovalue}

  end

  def _most_active_users
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5) 
    require 'will_paginate/array'
  end  

  # GET /entries
  def index
    @entries = Entry.all.paginate(page: params[:page], :per_page => 5)
    require 'will_paginate/array'

  end

  # GET /entries/1
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to @entry, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:agent_id, :department_id, :occurrence_id, :edate, :edesc, occurrence: [:ovalue])
    end
end
