class EventsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_as_author_or_lider, only: [:destroy, :update]
  before_action :authorize_create, only: [:create]
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events, include: []
  end

  # GET /events/1
  def show
    if @event.errors.any?
      render json: @event.errors.messages
    else
      render json: @event, include: []
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event,include: []
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event, include: []
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    if @event.destroy
      render json: @event, include: []
    else
      render json: @event.errors, status: 500
    end  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:topic, :description, :type_ev, :date, :frequence, :end_time, :state, :research_group_id)
    end

    def authorize_as_author_or_lider
      group_id = Event.get_group_id(params[:id])
      unless current_user.is_author_event?(params[:id]) || current_user.is_lider_of_research_group?(group_id)
        render_unauthorize
      end
    end

    def authorize_create
      group_id = Event.get_group_id(params[:id])
      unless current_user.is_lider_of_research_group?(group_id)
      end
    end
end
