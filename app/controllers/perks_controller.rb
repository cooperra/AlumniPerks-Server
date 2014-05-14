class PerksController < ApplicationController
  before_action :set_perk, only: [:show, :edit, :update, :destroy]

  # GET /perks
  # GET /perks.json
  # Only show perks that haven't been deleted
  def index
    @perks = Perk.active.order('company_name ASC')
  end

  # GET /perks/1
  # GET /perks/1.json
  def show
  end

  # GET /perks/new
  def new
    @perk = Perk.new
  end

  # GET /perks/1/edit
  def edit
  end

  # POST /perks
  # POST /perks.json
  def create
    @perk = Perk.new(perk_params)

    respond_to do |format|
      if @perk.save
        format.html { redirect_to @perk, notice: 'Perk was successfully created.' }
        format.json { render action: 'show', status: :created, location: @perk }
      else
        format.html { render action: 'new' }
        format.json { render json: @perk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perks/1
  # PATCH/PUT /perks/1.json
  def update
    respond_to do |format|
      if @perk.update(perk_params)
        format.html { redirect_to @perk, notice: 'Perk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @perk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perks/1
  # DELETE /perks/1.json
  # Soft delete only
  def destroy
    @perk.soft_delete
    respond_to do |format|
      format.html { redirect_to perks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perk
      @perk = Perk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perk_params
      params[:perk].permit([:company_name, :company_address, :company_phone, :description, :website, :coupon, :is_deleted, :image])
    end
end
