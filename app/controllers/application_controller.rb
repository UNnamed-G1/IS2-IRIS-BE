class ApplicationController < ActionController::API
    include Knock::Authenticable

    private 
        def unauthorized_entity(entity_name)
            render json: ["You are unauthorized to access this."], status: :unauthorized
        end
end
