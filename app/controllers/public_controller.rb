class PublicController < ApplicationController
  skip_before_action :authenticate_user!

  def about
  end

  def payments
  end

  def features
  end

  def product
  end
end
