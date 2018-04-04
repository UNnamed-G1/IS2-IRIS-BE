class ApplicationController < ActionController::API
    include Knock::Authenticable

    UNAUTHORIZED_MESSAGE = "You are unauthorized to access this."

    def authorize_as_admin
        render json: [UNAUTHORIZED_MESSAGE], status: :unauthorized unless !current_user.nil? && current_user.is_admin?
    end

    def authorize_as_student
        render json: [UNAUTHORIZED_MESSAGE], status: :unauthorized unless !current_user.nil? && current_user.is_student?
    end

    def authorize_as_student
        render json: [UNAUTHORIZED_MESSAGE], status: :unauthorized unless !current_user.nil? && current_user.is_profesor?
    end

    protected
        def unauthorized_entity(entity_name)
            render json: [UNAUTHORIZED_MESSAGE], status: :unauthorized
        end
end
