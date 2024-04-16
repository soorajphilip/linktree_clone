class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update]

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to tree_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to tree_index_path
    else
      render :edit
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
