class ResearchSubjectsController < ApplicationController
  #before_action :authenticate_user, except: %i[index show]
  before_action :authorize_as_admin, only: %i[update destroy create]
  before_action :set_research_subject, only: %i[show update destroy]

  # GET /research_subjects
  def index
    research_subjects = ResearchSubject.items(params[:page])
    render json: {
            research_subjects: research_subjects,
            total_pages: research_subjects.total_pages
           }, include: []
  end

  # GET /research_subjects/1
  def show
    if @research_subject.errors.any?
      render json: @research_subject.errors.messages
    else
      render json: @research_subject, include: []
    end
  end

  # POST /research_subjects
  def create
    @research_subject = ResearchSubject.new(research_subject_params)

    if @research_subject.save
      render json: @research_subject, status: :created, location: @research_subject, include: []
    else
      render json: @research_subject.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /research_subjects/1
  def update
    if @research_subject.update(research_subject_params)
      render json: @research_subject, include: []
    else
      render json: @research_subject.errors, status: :unprocessable_entity
    end
  end

  # DELETE /research_subjects/1
  def destroy
    if @research_subject.destroy
      render json: @research_subject, include: []
    else
      render json: @research_subject.errors, status: 500
    end
  end

  def search_rs_by_rg
    rs_by_rg = ResearchSubject.search_rs_by_rg(params[:id]).items(params[:page])
    render json: {
            research_subjects: rs_by_rg,
            total_pages: rs_by_rg.total_pages
           },fields: %i[id name], include: []
  end

  def search_rs_by_name
    rs_by_name = ResearchSubject.search_rs_by_name(params[:keywords]).items(params[:page])
    render json: {
            research_subjects: rs_by_name,
            total_pages: rs_by_name.total_pages
           }, fields: %i[id name], include: []
  end

  def search_rs_by_user
    rs_by_user = ResearchSubject.search_rs_by_user(params[:id]).items(params[:page])
    render json: {
            research_subjects: rs_by_user,
            total_pages: rs_by_user.total_pages
           }, fields: %i[id name], include: []
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_research_subject
    @research_subject = ResearchSubject.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def research_subject_params
    params.require(:research_subject).permit(:name)
  end
end
