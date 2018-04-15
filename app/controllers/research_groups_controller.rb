class ResearchGroupsController < ApplicationController
  before_action :authenticate_user, except: %i[index show news]
  before_action :authorize_as_admin, only: %i[destroy create]
  before_action :authorize_update, only: [:update]
  before_action :set_research_group, only: %i[show update destroy]

  # GET /research_groups
  def index
    @research_groups = ResearchGroup.items(params[:page])
    render json: {
      research_groups: @research_groups,
      total_pages: @research_groups.total_pages
    }, include: []
  end

  # GET /research_groups/1
  def show
    if @research_group.errors.any?
      render json: @research_group.errors.messages
    else
      render json: @research_group, include: ['users', 'members', 'members.user'] # This is an example of associations that are brought
    end
  end

  # POST /research_groups
  def create
    @research_group = ResearchGroup.new(research_group_params)

    if @research_group.save
      picture = params[:picture] 
      @research_group.update(photo: Photo.create_photo(picture, @research_group)) if picture
      render json: @research_group, status: :created, location: @research_group, include: [:photo]
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /research_groups/1
  def update
    if @research_group.update(research_group_params)
      picture = params[:picture]
      @research_group.photo.update(picture: picture) if picture
      render json: @research_group, include: [:photo]
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /research_groups/1
  def destroy
    if @research_group.destroy
      render json: @research_group, include: []
    else
      render json: @research_group.errors, status: 500
    end
  end

  # GET /research_groups/:id
  def get_photo
    set_research_group
    response = {}
    response["photo"] = Base64.strict_encode64(File.read("#{Rails.root}/public/#{@research_group.photo.picture.url}"))
    render json: response, status: :ok
  end

  def search_rgs_by_career
    rgs_by_career = ResearchGroup.search_rgs_by_career(params[:id])
    render json: rgs_by_career, fields: %i[id name], include: []
  end

  def search_rgs_by_name
    rgs_by_name = ResearchGroup.search_rgs_by_name(params[:keywords])
    render json: rgs_by_name, fields: %i[id name], include: []
  end

  def search_rgs_by_class
    rgs_by_class = ResearchGroup.search_rgs_by_class(params[:cl_type])
    render json: rgs_by_class, fields: %i[id name], include: []
  end

  def search_rgs_by_department
    rgs_by_department = ResearchGroup.search_rgs_by_dept(params[:id])
    render json: rgs_by_department, fields: %i[id name], include: []
  end

  def news
    research_groups = ResearchGroup.news
    fields = %i[name description updated_at]
    render json: research_groups, fields: fields, include: [:photo]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_research_group
    @research_group = ResearchGroup.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def research_group_params
    params.require(:research_group).permit(:name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, :url)
  end

  def authorize_update
    unless current_user.is_lider_of_research_group?(params[:id]) || current_user.is_admin?
      render_unauthorize
    end
  end
end
