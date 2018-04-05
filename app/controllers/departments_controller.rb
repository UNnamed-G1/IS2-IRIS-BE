class DepartmentsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_as_admin, except: [:index,:show]
  before_action :set_department, only: [:show, :update, :destroy]

  # GET /departments
  def index
    @departments = Department.paginate(:page => params[:page], :per_page => 5)

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
