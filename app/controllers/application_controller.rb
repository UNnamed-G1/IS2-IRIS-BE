class ApplicationController < ActionController::API
    include Knock::Authenticable

    def authorize_as_admin
        puts "asdadad"
        render json: ["You are unauthorized to access this."], status: :unauthorized unless !current_user.nil? && current_user.is_admin?
    end

    private 
        def unauthorized_entity(entity_name)
            render json: ["You are unauthorized to access this."], status: :unauthorized
        end
end
