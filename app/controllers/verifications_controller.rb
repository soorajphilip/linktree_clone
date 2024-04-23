class VerificationsController < ApplicationController
  def index
  end

  def verify
    if params[:verification_code] == session[:verification_code]
      current_user.update(phone_number: params[:user][:phone_number], phone_verified: true)
      redirect_to edit_user_registration_path, notice: "Verification successful."
    else
      redirect_to verification_path, alert: "Verification failed."
    end
  end
end
