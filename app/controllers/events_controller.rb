class EventsController < ApplicationController
  before_action :authenticate_user
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.paginate(:page => params[:page], :per_page => 5)
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

  def search_events_by_rg
    @events_by_rg = Event.search_events_by_rg(params[:id])
    reder json: events_by_rg, fields: [:id, :name, :topic, :type_ev], include: []
  end

  def search_events_by_user
    @events_by_user = Event.search_events_by_user(params[:id])
    reder json: events_by_user, fields: [:id, :name, :topic, :type_ev], include: []
  end

  def search_events_by_state
    @events_by_state = Event.search_events_by_state(params[:status])
    reder json: events_by_state, fields: [:id, :name, :topic, :type_ev], include: []
  end

  def search_events_by_freq
    @events_by_freq = Event.search_events_by_freq(params[:freq])
    reder json: events_by_freq, fields: [:id, :name, :topic, :type_ev], include: []
  end

  def search_events_by_type
    @events_by_type = Event.search_events_by_type(params[:type])
    reder json: events_by_type, fields: [:id, :name, :topic, :type_ev], include: []
  end

  def news
    @events = Event.news
    render json: @events, include: [:photo]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:topic, :description, :type_ev, :date, :frequence, :end_time, :state, :research_group_id)
    end
end
