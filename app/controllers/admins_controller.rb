class AdminsController < ApplicationController
  before_filter :authenticate_admin!

  # GET /admins/new
  def new
    @admin = Admin.new
    @resource = @admin
  end

  # POST /admins/new
  def create
    @admin = Admin.new(admin_params)
    @resource = @admin

    if @admin.save
      flash.now[:notice] = "Admin #{@admin.email} was successfully created."
      render action: 'new'
    else
      render action: 'new'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params[:admin].permit(:email, :password, :password_confirmation)
    end
end
