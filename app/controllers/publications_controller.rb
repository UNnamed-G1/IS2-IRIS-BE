class PublicationsController < ApplicationController
  before_action :authenticate_user, except: %i[show index]
  before_action :authorize_as_lider, only: %i[destroy]
  before_action :authorize_update, only: [:update]
  before_action :set_publication, only: %i[show update destroy]

  # GET /publications
  def index
    @publications = Publication.items(params[:page])
    render json: {
      publications: @publications,
      total_pages: @publications.total_pages
    }, include: []
  end

  # GET /publications/1
  def show
    if @publication.errors.any?
      render json: @publication.errors.messages
    else
      render json: @publication, include: []
    end
  end

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
    end
  end

  def search_publications_by_rg
    publications_by_rg = Publication.search_publications_by_rg(params[:id])
    render json: publications_by_rg, fields: %i[id name type_pub], include: []
  end

  def search_publications_by_user
    publications_by_user = Publication.search_publications_by_user(params[:id])
    render json: publications_by_user, fields: %i[id name type_pub], include: []
  end

  def search_publications_by_type
    publications_by_type = Publication.search_publications_by_type(params[:type])
    render json: publications_by_type, include: []
  end

  def search_p_by_rg_and_type
    p_by_rg_and_type = Publication.search_p_by_rg_and_type(params[:id], params[:type])
    render json: p_by_rg_and_type, fields: %i[id name type_pub], include: []
  end

  def num_publications_by_rg
    num_publications_by_rg = Publication.num_publications_by_rg(params[:id])
    render json: num_publications_by_rg, include: []
  end

  def num_publications_by_user
    num_publications_by_user = Publication.num_publications_by_user(params[:id])
    render json: num_publications_by_user, include: []
  end

  def num_publications_by_type
    num_publications_by_type = Publication.num_publications_by_type(params[:type])
    render json: num_publications_by_type, include: []
  end

  def num_publications_by_rg_and_type
    num_publications_by_rg_and_type = Publication.num_publications_by_rg_and_type(params[:id], params[:type])
    render json: num_publications_by_rg_and_type, include: []
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def publication_params
    params.require(:publication).permit(:name, :date, :abstract, :document, :brief_description, :type_pub)
  end

  def authorize_as_lider
    unless current_user.is_lider_of_research_group?(params[:id_group])
      render_unauthorize
    end
  end

  def authorize_update
    group_ids = Publication.get_research_groups(params[:id])
    is_lider = false
    for group in group_ids

      if current_user.is_lider_of_research_group?(group)
        is_lider = true
        break
      end
    end
    unless current_user.is_author_publication?(params[:id]) || is_lider
      render_unauthorize
    end
  end
end
