class PublicationsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :authorize_as_lider, only: [:create, :destroy]
  before_action :authorize_update, only: [:update]
  before_action :set_publication, only: [:show, :update, :destroy]

  # GET /publications
  def index
    @publications = Publication.all

    render json: @publications, include: []
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def publication_params
      params.require(:publication).permit(:name, :date, :abstract, :url, :brief_description, :file_name, :type_pub)
    end

    def authorize_as_lider
      unless current_user.is_lider_of_research_group?(params[:id])
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
