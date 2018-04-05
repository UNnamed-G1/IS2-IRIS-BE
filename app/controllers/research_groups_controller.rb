class ResearchGroupsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_as_admin, only: [:destroy, :create]
  before_action :authorize_update, only: [:update]
  before_action :set_research_group, only: [:show, :update, :destroy]

  # GET /research_groups
  def index
    @research_groups = ResearchGroup.paginate(:page => params[:page], :per_page => 5)

    render json: @research_groups, include: []
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
      render json: @research_group, status: :created, location: @research_group, include: []
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /research_groups/1
  def update
    if @research_group.update(research_group_params)
      render json: @research_group, include: []
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

  def search_rgs_by_career
    @rgs_by_career = ResearchGroup.search_rgs_by_career(params[:id])
    render json: rgs_by_career, fields: [:id, :name], include: []
  end

  def search_rgs_by_name
    @rgs_by_name = ResearchGroup.search_rgs_by_name(params[:keywords])
    render json: rgs_by_name, fields: [:id, :name], include: []
  end

  def search_rgs_by_class
    @rgs_by_class = ResearchGroup.search_rgs_by_class(params[:cl_type])
    render json: rgs_by_class, fields: [:id, :name], include: []
  end

  def search_rgs_by_department
    @rgs_by_department = ResearchGroup.search_rgs_by_department(params[:id])
    render json: rgs_by_department, fields: [:id, :name], include: []
  end

  def news
    @research_groups = ResearchGroup.news
    render json: @research_groups, include: [:photo]
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
