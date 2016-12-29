class ClickableController < ApplicationController
  before_action :set_clickables, only: [:destroy_all]

  def create
    @clickable = Image.find(params[:image_id]).clickables.build(clickable_params)
    
    if @clickable.save
      flash[:notice] = "clickable was successfully created."
      render nothing: true
    else
      flash[:notice] = "clickable was fail created."
      render nothing: true
    end
  end

  def destroy_all
    unless @clickables.nil?
      @clickables.each(&:destroy)
    end
    render nothing: true
  end

  private

  def clickable_params
    params.require(:clickable).permit(:target_image_id, :top, :left, :width, :height)
  end

  def set_clickables
    @clickables = Image.find(params[:image_id]).clickables
  end

end