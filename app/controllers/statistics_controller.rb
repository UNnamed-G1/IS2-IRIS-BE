class StatisticsController < ApplicationController

    def num_publications_by_user
        user_id = params[:id]
        num_publications_by_user = Publication.num_publications_by_user(user_id)
        if num_publications_by_user == 0
            render json:{
                message: "El usuario no registra publicaciones hasta el momento"
            }, status: :error
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
                message: "El grupo no registra publicaciones hasta el momento"
            }, status: :error
        else    
            render json:{
                num_publications_by_rg: num_publications_by_rg
            }, status: :ok
        end
    end
  
    def num_publications_by_user_in_a_period
        user_id = params[:id]
        num_publications_by_user = Publication.num_publications_by_user(user_id)
        if num_publications_by_user == 0
            render json:{
                message: "El usuario solicitado no registra publicaciones"
            }, status: :error
        else
            render json:{
                num_publications_of_users_in_a_period: Publication.num_publications_by_user_in_a_period(user_id)
            }, status: :ok
        end
    end

    def num_publications_by_rg_in_a_period
        rg_id = params[:id]  
        num_publications_by_rg = Publication.num_publications_by_rg(rg_id)
        if num_publications_by_rg == 0
            render json:{
                message: "El grupo solicitado no registra publicaciones"
            }, status: :error
        else
            render json:{
                num_publications_of_users_in_a_period: Publication.num_publications_by_rg_in_a_period(rg_id)
            }, status: :ok
        end
    end  

    def recent_publications_by_user
        user_id = params[:id]
        recent_publications_by_user = Publication.search_recent_publications_by_user(user_id)
        if recent_publications_by_user.empty?
            render json:{
                message: "No hay publicaciones recientes"
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
                message: "No hay publicaciones recientes"
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
        user = User.find_by_id(user_id)
        data["user"] = user.name
        data["publications"] = user.get_publications
        data["stats_publication"] = Hash.new
        publication_types = Publication.type_pubs.keys
        if data["publications"].empty?
            render json: {
                message: "El usuario no registra publicaciones a la fecha",
            }, status: :error
        else
            (publication_types).each { |type| data["stats_publication"][type.capitalize] = Publication .num_publications_by_user_and_type(user_id, type)}                
            render json: {
                num_publications_by_user_and_type: data["stats_publication"]
            }, status: :ok
        end
    end

    def num_publications_by_rg_and_type
        rg_id = params[:id]    
        data = Hash.new
        research_group = ResearchGroup.find_by_id(rg_id)
        data["research_group_name"] = research_group.name
        data["publications"] = research_group.get_publications
        data["stats_publication"] = Hash.new
        publication_types = Publication.type_pubs.keys
        if data["publications"].empty?
            render json: {
                message: "El grupo no registra publicaciones a la fecha",
            }, status: :error
        else
            (publication_types).each { |type| data["stats_publication"][type.capitalize] = Publication .num_publications_by_rg_and_type(rg_id, type)}                

            render json: {
                num_publications_by_rg_and_type: data["stats_publication"]
            }, status: :ok
        end
    end

    def overall_num_pubs_by_users_in_rg
        rg_id = params[:id]
        data = Hash.new
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
            render json: {
                average_publications_in_a_period_by_rg: "No se registran publicaciones en el periodo seleccionado",
            }, status: :error
        else
            data["stats_publication"] = data["num_publications_in_a_period_by_rg"] / time
            render json: {
                average_publications_in_a_period_by_rg: data["stats_publication"],
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
            render json: {
                average_publications_in_a_period_by_user: "No se registran publicaciones en el periodo seleccionado",
            }, status: :error
        else
            data["stats_publication"] = data["num_publications_in_a_period_by_user"] / time
            render json: {
                average_publications_in_a_period_by_user: data["stats_publication"],
            }, status: :ok
        end
    end
end
