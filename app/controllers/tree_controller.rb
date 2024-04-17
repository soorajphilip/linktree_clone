class TreeController < ApplicationController

  def index
    @links = @user.links
  end
end
