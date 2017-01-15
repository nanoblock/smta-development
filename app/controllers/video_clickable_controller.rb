class VideoClickableController < ApplicationController
  before_action :set_clickables, only: [:destroy_all]

  def create
    @clickable = Video.find(params[:video_id]).video_clickables.build(clickable_params)
    
    if @clickable.save
      flash[:notice] = "clickable was successfully created."
      render nothing: true
    else
      flash[:notice] = "clickable was fail created."
      render nothing: true
    end
  end

  def destroy_all

    return render status: :no_content, json: {"message": "No content video clickable area."} unless @clickables
    @clickables.each(&:destroy) if @clickables

    render nothing: true
  end

  private

  def clickable_params
    params.require(:clickable).permit(:time, :top, :left, :width, :height)
  end

  def set_clickables
    @clickables = Video.find(params[:video_id]).video_clickables
  end

end