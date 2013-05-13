#coding=utf-8
class Admin::ImagesController < Admin::ApplicationController
  def index
    @images = Image.where({:imageable_type=>params[:imageable_type], :imageable_id => params[:imageable_id]}).order(:order).all
  end

  def edit
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html { render :template => 'admin/images/edit' }
      format.js { j render :layout => false, :template => 'admin/images/edit' }
    end
  end

  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      else
        format.js
      end
    end
  end
end
