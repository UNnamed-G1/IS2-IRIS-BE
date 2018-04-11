class DepartmentsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_as_admin, except: %i[index show search_deps_by_faculty]
  before_action :set_department, only: %i[show update destroy]

  # GET /departments
  def index
    @departments = Department.all
    render json: @departments, include: []
  end

  # GET /departments/1
  def show
    if @department.errors.any?
      render json: @department.errors.messages
    else
      render json: @department, include: []
    end
  end

  # POST /departments
  def create
    @department = Department.new(department_params)

    if @department.save
      render json: @department, status: :created, location: @department, include: []
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departments/1
  def update
    if @department.update(department_params)
      render json: @department, include: []
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # DELETE /departments/1
  def destroy
    if @department.destroy
      render json: @department, include: []
    else
      render json: @department.errors, status: 500
    end
  end

  def paginate
    departments = Department.paginate(page: params[:page], per_page: 5)
    render json: departments, include: []
  end

  def search_deps_by_faculty
    deps_by_faculty = Department.search_deps_by_faculty(params[:id])
    render json: deps_by_faculty, fields: %i[id name], include: []
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def department_params
    params.require(:department).permit(:name)
  end
end
