class ApplicationController < ActionController::API
    include Knock::Authenticable

    UNAUTHORIZED_MESSAGE = "You are unauthorized to access this."

    def authorize_as_admin
        render_unauthorize unless current_user.is_admin?
    end

    def authorize_as_student
        render_unauthorize unless current_user.is_student?
    end

    def authorize_as_profesor
        render_unauthorize unless current_user.is_profesor?
    end

    protected
        def unauthorized_entity(entity_name)
            render_unauthorize
        end

        def render_unauthorize
            render json: [UNAUTHORIZED_MESSAGE], status: :unauthorized
        end

        def get_mandatory_parameter(params, param_name)
            if !params.key?(param_name)
                render json: {error: "The parameter #{param_name} is required."}, statu: 400
            else
                return params[param_name]
            end
        end
end
