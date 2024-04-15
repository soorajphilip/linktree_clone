class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :redirect_signed_in_users_to_dashboard

  def index
  end

  private

  def redirect_signed_in_users_to_dashboard
    redirect_to tree_index_path if signed_in?
  end
end
