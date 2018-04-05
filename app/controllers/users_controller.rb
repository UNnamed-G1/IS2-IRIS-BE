class UsersController < ApplicationController
  # The json to be received when the user will be created
  # has to follow the next format: { "user": { Here goes the info of the new user } }

  before_action :authenticate_user, except: :create
  # before_action :authorize_as_admin, except: [:create, :current]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
    render json: @users, include: [] # This include is for select which associations bring in the JSON
  end

  # GET /users/1
  def show
    if @user.errors.any?
      render json: @user.errors.messages
    else
      render json: @user, include: []
    end
  end

  # POST /users
  def create
    @user = User.new (user_params)

    if @user.save
      render json: @user, status: :created, location: @user, include: []
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user, include: []
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      render json: @user, include: []
    else
      render json: @user.errors, status: 500
    end
  end

  def current
    fields = [:email, :username, :name, :lastname, :full_name, :user_type]
    render json: current_user, fields: fields, include: [:photo]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :lastname, :username, :professional_profile, :email, :phone, :office, :cvlac_link, :career_id, :user_type, :password, :password_confirmation)
    end
end
