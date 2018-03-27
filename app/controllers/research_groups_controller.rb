class ResearchGroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_research_group, only: [:show, :update, :destroy]

  # GET /research_groups
  def index
    @research_groups = ResearchGroup.all

    render json: @research_groups, include: []
  end

  # GET /research_groups/1
  def show
    if @research_group.errors.any?
      render json: @research_group.errors.messages
    else
      render json: @research_group, include: ['users', 'members', 'members.user'] # This is an example of associations that are brought
    end  end

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
    end  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research_group
      @research_group = ResearchGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def research_group_params
      params.require(:research_group).permit(:name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, :url)
    end
end
