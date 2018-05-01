class StatisticsController < ApplicationController

    def num_publications_by_user
        user_id = params[:id]
        num_publications_by_user = Publication.num_publications_by_user(user_id)
        if num_publications_by_user == 0
            render json:{
                num_publications_by_user: "El usuario no registra publicaciones hasta el momento"
            }, status: :ok
        else
            render json:{
                num_publications_by_users: num_publications_by_user
            }, status: :ok
        end
    end

    def num_publications_by_rg
        rg_id = params[:id]  
        num_publications_by_rg = Publication.num_publications_by_rg(rg_id)
        if num_publications_by_rg == 0
            render json:{
                num_publications_by_rg: "El grupo no registra publicaciones hasta el momento"
            }, status: :ok
        else    
            render json:{
                num_publications_by_rg: num_publications_by_rg
            }, status: :ok
        end
    end

    def recent_publications_by_user
        user_id = params[:id]
        recent_publications_by_user = Publication.search_recent_publications_by_user(user_id)
        if recent_publications_by_user.empty?
            render json:{
                recent_publications_by_user: "No hay publicaciones recientes"
            }, status: :ok
        else    
            render json:{
                recent_publications_by_user: recent_publications_by_user
            }, status: :ok
        end
    end
    
    def recent_publications_by_rg
        rg_id = params[:id]
        recent_publications_by_rg = Publication.search_recent_publications_by_rg(rg_id)
        if recent_publications_by_rg.empty?
            render json:{
                recent_publications_by_rg: "No hay publicaciones recientes"
            }, status: :ok
        else    
            render json:{
                recent_publications_by_rg: recent_publications_by_rg
            }, status: :ok
        end
    end

    def num_publications_by_user_and_type
        user_id = params[:id]
        data = Hash.new
        data['user'] = User.find_by_id(user_id).name
        data["publications"] = Publication.search_publications_by_user(user_id)
        data["stats_publication"] = Array.new
        publication_types = Publication.type_pubs.values 
        if data["publications"].empty?
            render json:{
                num_publications_by_user_and_type: "El usuario no registra publicaciones a la fecha"
            }, status: :ok
        else
            for publication_type in publication_types do
                data["stats_publication"][publication_type] = Publication.num_publications_by_user_and_type(user_id, publication_type)
            end
        
            render json:{
                num_publications_by_user_and_type: data["stats_publication"]
            }, status: :ok
        end
    end

    def num_publications_by_rg_and_type
        rg_id = params[:id]
        data = Hash.new
        data["research_group_name"] = ResearchGroup.find_by_id(rg_id).name
        data["publications"] = Publication.search_publications_by_rg(rg_id)
        data["stats_publication"] = Array.new
        publication_types = Publication.type_pubs.values 
        if data["publications"].empty?
            render json:{
                num_publications_by_rg_and_type: "El grupo no registra publicaciones a la fecha"
            }, status: :ok
        else
            for publication_type in publication_types do
                    data["stats_publication"][publication_type] = Publication.num_publications_by_rg_and_type(rg_id, publication_type)
            end

            render json:{
                num_publications_by_rg_and_type: data
            }, status: :ok
        end
    end

    def overall_num_pubs_by_users_in_rg
        rg_id = params[:id]
        data = Hash.new
        data["research_group_name"] = ResearchGroup.find_by_id(rg_id).name
        data["users_in_rg"] = User.search_users_by_rg(rg_id)
        data["stats_publication"] = Array.new
        
        data["stats_publication"] = User.with_publications_count_in_rg(rg_id)
        
        render json:{
            overall_num_pubs_by_users_in_rg: data["stats_publication"]
        }, status: :ok
        
    end

    def average_publications_in_a_period_by_rg #Monthly average in the last 3 or 6 months
        rg_id = params[:id]
        period = params[:period]
        data = Hash.new
        data["research_group_name"] = ResearchGroup.find_by_id(rg_id).name

        # 0 for 3 months, 1 for 6 months

        if period == 0
            time = 3
        else
            time = 6
        end

        data["num_publications_in_a_period_by_rg"] = Publication.num_publications_in_a_period_by_rg(rg_id, time)        
        
        if data["num_publications_in_a_period_by_rg"] == 0
            render json:{
                average_publications_in_a_period_by_rg: "No se registran publicaciones en el periodo seleccionado"
            }, status: :ok
        else
            data["stats_publication"] = data["num_publications_in_a_period_by_rg"] / time    
            render json:{
                average_publications_in_a_period_by_rg: data["stats_publication"]
            }, status: :ok
        end        
    end
    
    def average_publications_in_a_period_by_user #Monthly average in the last 3 or 6 months
        user_id = params[:id]
        period = params[:period]
        data = Hash.new
        data["user_name"] = User.find_by_id(user_id).name

        # 0 for 3 months, 1 for 6 months

        if period == 0
            time = 3
        else
            time = 6
        end

        data["num_publications_in_a_period_by_user"] = Publication.num_publications_in_a_period_by_user(user_id, time)        
        
        if data["num_publications_in_a_period_by_user"] == 0
            render json:{
                average_publications_in_a_period_by_user: "No se registran publicaciones en el periodo seleccionado"
            }, status: :ok
        else
            data["stats_publication"] = data["num_publications_in_a_period_by_user"] / time    
            render json:{
                average_publications_in_a_period_by_user: data["stats_publication"]
            }, status: :ok
        end       
    end  

end