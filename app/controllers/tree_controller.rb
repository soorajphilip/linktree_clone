class TreeController < ApplicationController

  def index
    @links = Link.all
  end
end
