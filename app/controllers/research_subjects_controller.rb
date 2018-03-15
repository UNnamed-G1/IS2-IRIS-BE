class ResearchSubjectsController < ApplicationController
  before_action :set_research_subject, only: [:show, :update, :destroy]

  # GET /research_subjects
  def index
    @research_subjects = ResearchSubject.all

    render json: @research_subjects
  end

  # GET /research_subjects/1
  def show
    if @research_subjects.errors.any?
      render json: @research_subjects.errors.messages
    else
      render json: @research_subjects
    end
  end

  # POST /research_subjects
  def create
    @research_subject = ResearchSubject.new(research_subject_params)

    if @research_subject.save
      render json: @research_subject, status: :created, location: @research_subject
    else
      render json: @research_subject.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /research_subjects/1
  def update
    if @research_subject.update(research_subject_params)
      render json: @research_subject
    else
      render json: @research_subject.errors, status: :unprocessable_entity
    end
  end

  # DELETE /research_subjects/1
  def destroy
    if @research_subject.destroy
      render json: @research_subject
    else
      render json: @research_subject.errors, status: 500
    end
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
