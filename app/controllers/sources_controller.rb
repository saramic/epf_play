class SourcesController < ApplicationController
  def index
    @sources = Source.all
  end

  def new
    @source = Source.new
  end

  def edit
    @source = Source.find(params[:id])
  end

  def create
    @source = Source.new(params[:source])
    # TODO ultimately this should be a worker/delayedJob/externalSweepJob
    url = URI.parse @source.url
    @source.remote_asset_url = url.to_s
    if @source.save
      flash[:notice] = "Source \"#{@source}\" has been successfully created!"
      redirect_to edit_source_path @source
    else
      flash[:error] = "Source not created. Please review the messages below."
      render :new
    end
  end

  def update
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      flash[:notice] = "Source \"#{@source}\" has been successfully updated!"
      redirect_to edit_source_path(@source)
    else
      flash[:error] = "Source not updated. Please review the messages below."
      render :edit
    end
  end

end