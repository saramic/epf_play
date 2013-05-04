class SourcesController < ApplicationController
  def index

  end

  def new
    @source = Source.new
  end

  def edit
    @source = Source.find(params[:id])
  end

  def create
    @source = Source.new(params[:source])
    if @source.save
      flash[:notice] = "Source \"#{@source}\" has been successfully created!"
      redirect_to edit_source_path @source
    else
      flash[:error] = "Source not created. Please review the messages below."
      render :new
    end
  end
  #
  #def update
  #  if @taxon.update_attributes(params[:taxon])
  #    flash[:notice] = "Taxon \"#{@taxon}\" #{"with parent \"#{@taxon.parent}\" " unless @taxon.parent.nil?}has been successfully updated!"
  #    redirect_to edit_administration_taxon_path  @taxon
  #  else
  #    respond_with @taxon, :location => edit_administration_taxon_path(@taxon)
  #  end
  #end

end