class SchedulesController < ApplicationController
  before_action :authenticate_user
  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  def index
    @schedules = Schedule.all

    render json: @schedules, include: []
  end

  # GET /schedules/1
  def show
    if @schedule.errors.any?
      render json: @schedule.errors
    else
      render json: @schedule, include: []
    end
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule, status: :created, location: @schedule, include: []
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render json: @schedule, include: []
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedules/1
  def destroy
    if @schedule.destroy
      render json: @schedule, include: []
    else
      render json: @schedule.errors, status: 500
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      params.require(:schedule).permit(:start, :end)
    end
end
