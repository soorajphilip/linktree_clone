class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user

  def after_sign_in_path_for(resource)
    tree_index_path
  end

  private

  def set_user
    @user = current_user
  end
end
