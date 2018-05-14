class SearchController < ApplicationController

    def search_events_by_name
        keywords = params[:keywords].upcase
        page = params[:page]
        events_by_name = Event.search_events_by_name(keywords).items(page)
        render json: {
                    events: events_by_name,
                    total_pages: events_by_name.total_pages,
               }, 
               fields: %i[id name topic event_type description state], 
               include: [],
               state: :ok
    end

    def search_publications_by_name
        keywords = params[:keywords].upcase
        page = params[:page]
        publications = Publication.search_publications_by_name(keywords).items(page)
        render json: {
            publications: publications,
            total_pages: publications.total_pages,
            }, 
            fields: %i[id name publication_type abstract], 
            include: [],
            state: :ok
    end

end