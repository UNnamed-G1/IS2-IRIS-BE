class FacultiesController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_as_admin, except: %i[index show]
  before_action :set_faculty, only: %i[show update destroy]

  # GET /faculties
  def index
    @faculties = Faculty.all
    render json: @faculties, include: []
  end

  # GET /faculties/1
  def show
    if @faculty.errors.any?
      render json: @faculty.errors.messages
    else
      render json: @faculty, include: []
    end
  end

  # POST /faculties
  def create
    @faculty = Faculty.new(faculty_params)

    if @faculty.save
      render json: @faculty, status: :created, location: @faculty, include: []
    else
      render json: @faculty.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /faculties/1
  def update
    if @faculty.update(faculty_params)
      render json: @faculty, include: []
    else
      render json: @faculty.errors, status: :unprocessable_entity
    end
  end

  # DELETE /faculties/1
  def destroy
    if @faculty.destroy
      render json: @faculty, include: []
    else
      render json: @faculty.errors, status: 500
    end
  end

  def paginate
    faculty = Faculty.paginate(page: params[:page], per_page: 5)
    render json: faculty, include: []
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_faculty
    @faculty = Faculty.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def faculty_params
    params.require(:faculty).permit(:name)
  end
end
