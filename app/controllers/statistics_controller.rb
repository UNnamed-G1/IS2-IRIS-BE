class StatisticsController < ApplicationController
    
    def index
    
    end 

    def show
    
    end

    def num_publications_by_user
        user_id = params[:id]
        num_pubs_by_user = Publication.num_publications_by_user(user_id)
        render json:{
            num_pubs: num_pubs_by_user
        }
    end

    def num_publications_by_rg
        rg_id = params[:id]
        num_pubs_by_rg = Publication.num_publications_by_rg(rg_id)
        render json:{
            num_pubs: num_pubs_by_rg
        }
    end

    def recent_publications_by_user
        user_id = params[:id]
        recent_publications = Publication.search_recent_publications_by_user(user_id)
        render json:{
            rec_pubs: recent_publications
        }
    end
    
    def recent_publications_by_rg
        rg_id = params[:id]
        recent_publications = Publication.search_recent_publications_by_rg(rg_id)
        render json:{
            rec_pubs: recent_publications
        }
    end

    
    def num_publications_by_user_and_type
        data = Hash.new
        user_id = params[:id]
        data['user'] = User.find_by_id(user_id).name
        data["publications"] = Publication.search_publications_by_user(user_id)
        data["stats_publication"] = Array.new
        publication_types = Publication.type_pubs.values 
        for publication_type in publication_types do
            data["stats_publication"][publication_type] = Publication.num_publications_by_user_and_type(user_id, publication_type)
        end
        
        render json:{
            types: data["stats_publication"]
        }
    end
    
    def num_publications_by_rg_and_type
        rg_id = params[:id]
        data = Hash.new
        data["research_group_name"] = ResearchGroup.find_by_id(rg_id).name
        data["publications"] = Publication.search_publications_by_rg(rg_id)
        data["stats_publication"] = Array.new
        publication_types = Publication.type_pubs.values 
        for publication_type in publication_types do
            data["stats_publication"][publication_type] = Publication.num_publications_by_rg_and_type(rg_id, publication_type)
        end

        render json:{
            types: data["stats_publication"]
        }
    end

    def overall_num_pubs_by_users_in_rg
        rg_id = params[:id]
        data = Hash.new
        data["research_group_name"] = ResearchGroup.find_by_id(rg_id).name
        data["users_in_rg"] = User.search_users_by_rg(rg_id)
        data["stats_publication"] = Array.new
        for user in data["users_in_rg"] do
            data["stats_publication"] = User.with_publications_count_in_rg(rg_id)
        end
        
        render json:{
            pubs: data["stats_publication"]
        }
    end

end