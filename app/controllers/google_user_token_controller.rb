class GoogleUserTokenController < ApplicationController

    # To login do a POST request to /google_user_token
    # where the json to receive has to be:
    # { "auth": { "access_token": "Token received from google" } }
    # This will return a 201 code is the authentication was 
    # correct and 404 if there was a problem with the autentication
    # (this error is by the side of the client - the data isn't correct)

    before_action :authenticate
    
    def create
      render json: auth_token, status: :created
    end
  
    private
  
    def authenticate
      unless entity.present?
        raise Knock.not_found_exception_class
      end
    end
  
    def auth_token
      if entity.respond_to? :to_token_payload
        Knock::AuthToken.new payload: entity.to_token_payload
      else
        Knock::AuthToken.new payload: { sub: entity.id }
      end
    end
  
    def entity
        @entity ||= 
            if GoogleService.valid_token?(auth_params[:access_token])
                data = GoogleService.fetch_data(auth_params[:access_token])
                User.create_or_find_google_user(data)
            end
    end
  
    def auth_params
      params.require(:auth).permit :access_token
    end
  end