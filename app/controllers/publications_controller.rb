class PublicationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_publication, only: [:show, :update, :destroy]

  # GET /publications
  def index
    @publications = Publication.paginate(:page => params[:page], :per_page => 5)
    
    render json: @publications, include: []
  end

  # GET /publications/1
  def show
    if @publication.errors.any?
      render json: @publication.errors.messages
    else
      render json: @publication, include: []
    end  end

  # POST /publications
  def create
    @publication = Publication.new(publication_params)

    if @publication.save
      render json: @publication, status: :created, location: @publication
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /publications/1
  def update
    if @publication.update(publication_params)
      render json: @publication, include: []
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # DELETE /publications/1
  def destroy
    if @publication.destroy
      render json: @publication, include: []
    else
      render json: @publication.errors, status: 500
    end  end

  def search_publications_by_rg
    @publications_by_rg = Publication.search_publications_by_rg(params[:id])
    render json: publications_by_rg, fields: [:id, :name, :type_pub], include: []
  end

  def search_publications_by_user
    @publications_by_user = Publication.search_publications_by_user(params[:id])
    render json: publications_by_user, fields: [:id, :name, :type_pub], include: []
  end

  def search_publications_by_type
    @publications_by_type = Publication.search_publications_by_type(params[:type])
    render json: publications_by_type, include: []
  end

  def search_p_by_rg_and_type
    @p_by_rg_and_type = Publication.search_p_by_rg_and_type(params[:id, :type])
    render json: p_by_rg_and_type, fields: [:id, :name, :type_pub], include: []
  end


  def num_publications_by_rg
    @num_publications_by_rg = Publication.num_publications_by_rg(params[:id])
    render json: num_publications_by_rg, include: []
  end

  def num_publications_by_user
    @num_publications_by_user = Publication.num_publications_by_user(params[:id])
    render json: num_publications_by_user, include: []
  end

  def num_publications_by_type
    @num_publications_by_type = Publication.num_publications_by_type(params[:type])
    render json: num_publications_by_type, include: []
  end

  def num_publications_by_rg_and_type
    @num_publications_by_rg_and_type = Publication.num_publications_by_rg_and_type(params[:id, :type])
    render json: num_publications_by_rg_and_type, include: []
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def publication_params
      params.require(:publication).permit(:name, :date, :abstract, :url, :brief_description, :file_name, :type_pub)
    end
end
