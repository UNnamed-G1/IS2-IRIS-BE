class CareersController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_as_admin, except: [:index,:show, :by_department]
  before_action :set_career, only: [:show, :update, :destroy]

  # GET /careers
  def index
    @careers = Career.all

    render json: @careers, include: []
  end

  # GET /careers/1
  def show
    if @career.errors.any?
      render json: @career.errors.messages
    else
      render json: @career, include: []
    end
  end

  # POST /careers
  def create
    @career = Career.new(career_params)

    if @career.save
      render json: @career, status: :created, location: @career, include: []
    else
      render json: @career.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /careers/1
  def update
    if @career.update(career_params)
      render json: @career, include: []
    else
      render json: @career.errors, status: :unprocessable_entity
    end
  end

  # DELETE /careers/1
  def destroy
    if @career.destroy
      render json: @career, include: []
    else
      render json: @career.errors, status: 500
    end
  end

  def by_department
    careers = Career.get_by_department(params[:department_id])
    render json: careers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_career
      @career = Career.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def career_params
      params.require(:career).permit(:name, :snies_code, :degree_type)
    end
end
