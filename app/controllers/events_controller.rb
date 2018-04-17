class EventsController < ApplicationController
  #before_action :authenticate_user, except: %i[index show news]
  before_action :authorize_as_author_or_lider, only: %i[destroy update]
  before_action :set_event, only: %i[show update destroy]

  # GET /events
  def index
    events = Event.items(params[:page])
    render json: {
             events: events,
             total_pages: events.total_pages,
           }, include: []
  end

  # GET /events/1
  def show
    if @event.errors.any?
      render json: @event.errors.messages
    else
      render json: @event, include: [:photos]
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      if params.has_key?(:pictures)
        params[:pictures].each do |picture|
          @event.photos.create(picture: picture)
        end
      end

      render json: @event, status: :created, location: @event, include: [:photos]
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      if params.has_key?(:pictures)
        params[:pictures].each do |picture|
          @event.photos.create(picture: picture)
        end
      end
      render json: @event, include: [:photos]
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
    end
  end

  def search_events_by_rg
    events_by_rg = Event.search_events_by_rg(params[:id]).items(params[:page])
    render json: {
             events: events_by_rg,
             total_pages: events_by_rg.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def search_events_by_user
    events_by_user = Event.search_events_by_user(params[:id]).items(params[:page])
    render json: {
             events: events_by_user,
             total_pages: events_by_user.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def search_events_by_state
    events_by_state = Event.search_events_by_state(params[:status]).items(params[:page])
    render json: {
             events: events_by_state,
             total_pages: events_by_state.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def search_events_by_freq
    events_by_freq = Event.search_events_by_freq(params[:freq]).items(params[:page])
    render json: {
             events: events_by_freq,
             total_pages: events_by_freq.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def search_events_by_type
    events_by_type = Event.search_events_by_type(params[:type]).items(params[:page])
    render json: {
             events: events_by_type,
             total_pages: events_by_type.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def evs_by_usr_and_type
    evs_by_usr_and_type = Event.evs_by_usr_and_type(params[:id]).items(params[:page])
    render json: {
             events: evs_by_usr_and_type,
             total_pages: evs_by_usr_and_type.total_pages,
           }, fields: %i[id name topic type_ev], include: []
  end

  def evs_by_editable
    evs = Event.evs_by_editable(current_user[:id], params[:page]).items(params[:page])
    render json: {
             events: evs,
             total_pages: evs.total_pages,
           }, include: []
  end

  def news
    events = Event.news
    fields = %i[topic description date]
    render json: events, fields: fields, include: [:photo]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:topic, :description, :type_ev, :date, :frequence, :duration, :state, :research_group_id)
  end

  def authorize_as_author_or_lider
    event_id = params[:id]
    group_id = Event.get_research_group_id(event_id)
    puts group_id
    unless current_user.is_author_event?(event_id) || current_user.is_lider_of_research_group?(group_id)
      render_unauthorize
    end
  end
end
