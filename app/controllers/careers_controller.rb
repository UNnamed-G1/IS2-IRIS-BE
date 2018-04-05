class CareersController < ApplicationController

  before_action :authenticate_user
  before_action :authorize_as_admin, except: [:index,:show]
  before_action :set_career, only: [:show, :update, :destroy]

  # GET /careers
  def index
    @careers = Career.paginate(:page => params[:page], :per_page => 5)

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

  def search_careers_by_rg
    careers_by_rg = Career.search_careers_by_rg(params[:id])
    render json: careers_by_rg, fields: [:id, :name], include: []
  end

  def search_careers_by_user
    careers_by_user = Career.search_careers_by_user(params[:id])
    render json: careers_by_user, fields: [:id, :name], include: []
  end

  def search_careers_by_dept
    careers_by_dept = Career.search_careers_by_dept(params[:id])
    render json: careers_by_dept, fields: [:id, :name], include: []
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
