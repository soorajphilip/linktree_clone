class RegistrationsController < Devise::RegistrationsController

  def update
    if current_user.valid_password?(params[:user][:current_password])
      if params[:user][:phone_number].present? && !current_user.phone_verified?
        send_verification_code(params[:user][:phone_number])
      else
        update_user_account
      end
    else
      redirect_to edit_user_registration_path, notice: "Current password is invalid."
    end
  end

  private

  def update_user_account
    if current_user.update_with_password(account_update_params)
      redirect_to edit_user_registration_path, notice: "Profile updated successfully."
    else
      redirect_to edit_user_registration_path, alert: current_user.errors.full_messages.join('. ')
    end
  end

  def send_verification_code(entered_phone_number)
    twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_from_phone = '+919645107710'

    verification_code = generate_verification_code
    formatted_phone_number = "+91#{entered_phone_number}"

    begin
      client = Twilio::REST::Client.new(twilio_account_sid, twilio_auth_token)
      client.messages.create(
        from: twilio_from_phone,
        to: formatted_phone_number,
        body: "Your verification code is #{verification_code}."
      )
    rescue Twilio::REST::RestError => e
      Rails.logger.error "Twilio Error: #{e.message}"
      redirect_to edit_user_registration_path, alert: "Failed to send verification code. Please try again later."
      return
    end
    session[:verification_code] = verification_code
    redirect_to verifications_path
  end

  def generate_verification_code
    rand(100_000..999_999)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :image, :phone_number)
  end
end
