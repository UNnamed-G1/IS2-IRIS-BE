class SearchController < ApplicationController

    def search_events_by_name
        events_by_name = Event.search_events_by_name(params[:keywords]).items(params[:page])
        render json: {
                    events: events_by_name,
                    total_pages: events_by_name.total_pages,
               }, 
               fields: %i[id name topic event_type description state], 
               include: [],
               state: :ok
    end

end