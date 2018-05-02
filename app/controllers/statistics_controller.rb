class StatisticsController < ApplicationController

    def num_publications_by_user
        user_id = params[:id]
        num_publications_by_user = Publication.num_publications_by_user(user_id)
        if num_publications_by_user == 0
            render json:{
                num_publications_by_user: "El usuario no registra publicaciones hasta el momento"
            }, status: :error
        else
            render json:{
                num_publications_by_users: num_publications_by_user
            }, status: :error
        end
    end

    def num_publications_of_users
        users_with_pubs_count = User.get_name_and_lastname
        puts users_with_pubs_count
        render json: {
            data: users_with_pubs_count
        }, status: :ok
    end

    def num_publications_by_rg
        rg_id = params[:id]  
        num_publications_by_rg = Publication.num_publications_by_rg(rg_id)
        if num_publications_by_rg == 0
            render json:{
                num_publications_by_rg: "El grupo no registra publicaciones hasta el momento"
            }, status: :error
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
            }, status: :error
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
            }, status: :error
        else    
            render json:{
                recent_publications_by_rg: recent_publications_by_rg
            }, status: :ok
        end
    end

    def num_publications_by_user_and_type
        user_id = params[:id]
        data = Hash.new
        user = User.find_by_id(user_id).name
        num_pubs_by_user = Publication.num_publications_by_user(user_id)
        publication_types = Publication.type_pubs.keys
        if num_pubs_by_user == 0
            render json:{
                num_publications_by_user_and_type: "El usuario no registra publicaciones a la fecha"
            }, status: :error
        else
            (publication_types).each { |pub_type| data[pub_type] = Publication.num_publications_by_user_and_type(user_id, pub_type) }
            render json:{
                num_publications_by_user_and_type: data
            }, status: :ok
        end
    end

    def num_publications_by_rg_and_type
        rg_id = params[:id]
        data = Hash.new
        research_group_name = ResearchGroup.find_by_id(rg_id).name
        num_pubs_by_rg = Publication.num_publications_by_rg(rg_id)
        publication_types = Publication.type_pubs.keys 
        if num_pubs_by_rg == 0
            render json:{
                num_publications_by_rg_and_type: "El grupo no registra publicaciones a la fecha"
            }, status: :error
        else
            (publication_types).each { |pub_type| data[pub_type] = Publication.num_publications_by_rg_and_type(rg_id, pub_type) }

            render json:{
                num_publications_by_rg_and_type: data
            }, status: :ok
        end
    end

    def overall_num_pubs_by_users_in_rg
        rg_id = params[:id]
        data = Hash.new
        num_users_by_rg = User.num_users_by_rg(rg_id)
        research_group_name = ResearchGroup.find_by_id(rg_id).name
        if num_users_by_rg == 0
            render json:{
                num_publications_by_rg_and_type: "El grupo no registra publicaciones a la fecha"
            }, status: :error
        else
            data[research_group_name] = User.with_publications_count_in_rg(rg_id)
        
            render json:{
                overall_num_pubs_by_users_in_rg: data
            }, status: :ok
        end
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
            }, status: :error
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
            }, status: :error
        else
            data["stats_publication"] = data["num_publications_in_a_period_by_user"] / time    
            render json:{
                average_publications_in_a_period_by_user: data["stats_publication"]
            }, status: :ok
        end       
    end  

end