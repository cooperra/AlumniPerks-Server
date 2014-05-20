# This class overrides Devise's normal registration behavior
# We don't want random internet people to sign up as admins!
class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:notice] = 'Registration is disabled.'
    redirect_to admin_session_path
  end

  def create
    flash[:notice] = 'Registration is disabled.'
    redirect_to admin_session_path
  end
end
