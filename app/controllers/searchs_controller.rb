class SearchController < ApplicationController

    def events_by_name
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

    def publications_by_name
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

    def research_groups_by_name
        keywords = params[:keywords].upcase
        page = params[:page]
        research_groups = ResearchGroup.search_rgs_by_name(keywords).items(page)
        data = {}
        data["research_groups"] = research_groups
        data["total_pages"] = research_groups.total_pages
        render json: data,
            include: [:photo],
            fields: [:id, :name, :description, :classification],
            state: :ok            
    end

    def users_by_name_or_username
        keywords = params[:keywords].upcase
        page = params[:page]
        users = User.search_by_name(keywords).items(page, 12)
        serialized_users = ActiveModel::Serializer::CollectionSerializer.new(
                users, 
                each_serializer: UserSerializer,
            )
        render json: {
                    users: serialized_users,
                    total_pages: users.total_pages
                },
                include: :photo, 
                state: :ok
    end

end