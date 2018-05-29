class PublicationsController < ApplicationController
  #before_action :authenticate_user, except: %i[show index]
  before_action :authorize_as_lider, only: %i[destroy]
  before_action :authorize_update, only: [:update]
  before_action :set_publication, only: %i[show update destroy]

  # GET /publications
  def index
    publications = Publication.items(params[:page])
    render json: {
            publications: publications,
            total_pages: publications.total_pages
           }, include: []
  end

  # GET /publications/1
  def show
    if @publication.errors.any?
      render json: @publication.errors.messages
    else
      render json: @publication, include: [:users, "users.photo"]
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

  def search_publications_by_name
    publications_by_name = Publication.search_publications_by_name(params[:keywords]).items(params[:page])
    render json: {
            research_groups: publications_by_name,
            total_pages: publications_by_name.total_pages
           }, fields: %i[id name publication_type], include: []
  end

  def search_publications_by_type
    publications_by_type = Publication.search_publications_by_type(params[:type]).items(params[:page])
    render json: {
            publications: publications_by_type,
            total_pages: publications_by_type.total_pages
            }, fields: %i[id name publication_type], include: []
  end
  
  # PUT /publications/:id/accept_publication
  def accept_publication
    set_publication
    @publication.state = states[:Aceptado]
    if @publication.save 
      render json:  @publication, include: [], status: :ok
    else
      render json: {"error": "There was an error trying to update the user"} 
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def publication_params
    params.require(:publication).permit(:name, :date, :abstract, :document, :brief_description, :publication_type, :state)
  end

  def is_lider_research_group_publication?
    group_ids = Publication.get_research_groups(params[:id])
    is_lider = false
    for group in group_ids
      if current_user.is_lider_of_research_group?(group)
        is_lider = true
        break
      end
    end
    return is_lider
  end

  def authorize_as_lider
    unless is_lider_research_group_publication?
      render_unauthorize
    end
  end

  def authorize_update
    is_lider = is_lider_research_group_publication?
    unless current_user.is_author_publication?(params[:id]) || is_lider
      render_unauthorize
    end
  end
end
