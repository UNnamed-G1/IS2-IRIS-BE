class UsersController < ApplicationController
  # The json to be received when the user will be created
  # has to follow the next format: { "user": { Here goes the info of the new user } }

  before_action :authenticate_user, except: [:create, :show, :index, :following, :followers, :by_username]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize_update, only: [:update]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.items(params[:page], 12)
    render json: {
             users: @users,
             total_pages: @users.total_pages,
           }, include: [] # This include is for select which associations bring in the JSON
  end

  # GET /users/1
  def show
    if @user.errors.any?
      render json: @user.errors.messages
    else
      render json: @user, include: [:photo, :career, :research_groups, :events, :publications, :research_subjects]
    end
  end

  # POST /users
  def create
    @user = User.new (user_params)

    if @user.save
      pic = params[:picture]
      @user.update(photo: Photo.create_photo(pic, @user)) if pic
      UserMailer.delay.sign_up_confirmation(@user)
      render json: @user, status: :created, location: @user, include: [:photo]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      picture = params[:picture]
      if @user.photo
        @user.photo.update(picture: picture) if picture
      else
        @user.update(photo: Photo.create_photo(picture, @user)) if picture
      end
      render json: @user, include: [:photo]
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

  # GET /users/current
  def current
    fields = [:id, :email, :username, :name, :lastname, :full_name, :user_type, :google_sign_up]
    render json: current_user, fields: fields, include: [:photo]
  end

  # GET /get_user/:username
  def get_user_by_username
    user = User.byUsername(params[:username])
    render json: user, include: [:photo, :career, :research_groups, :events, :publications, :research_subjects]
  end

  # POST /users/current/follow 
  def follow_user
    followed_user = User.find_by_id(params[:id_followed])
    result = Relationship.add_follower(current_user, followed_user)
    if result.errors.empty?
      UserMailer.delay.new_follower_mail(followed_user, current_user)
      render json: {message: "Acción realizada satisfactoriamente"}, status: :ok
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end
  
  # POST /users/current/unfollow 
  def unfollow_user
    user_to_unfollow = User.find_by_id(params[:id_followed])
    if current_user.unfollow(user_to_unfollow)
      render json: {message: "Has dejado de seguir a este usuario."}, status: :ok
    else
      render json: {message: "Error: el error no ha sido especificado"}, status: 500
    end
  end

  # POST /users/current/following
  def current_user_following
    result = {}
    result["following"] = current_user.get_following
    result["count"] = current_user.count_following
    render json: result, include: [:photo], status: :ok
  end

  # GET /users/:id/following
  def following
    result = {}
    if params.has_key?(:id)
      user = User.find_by(id: params[:id])
    else
      user = current_user
    end
    if user
      result["following"] = user.get_following.items(params[:page], 6)
      result["count"] = result["following"].total_entries
      result["total_pages"] = result["following"].total_pages
      render json: result, include: [:photo], status: :ok
    else
      render json: {message: "Error: Bad request"}, status: 400
    end
  end

  # GET /users/:id/followers
  def followers
    result = {}
    if params.has_key?(:id)
      user = User.find_by(id: params[:id])
    else
      user = current_user
    end
    if user
      result["followers"] = user.get_followers.items(params[:page], 6)
      result["count"] = result["followers"].total_entries
      result["total_pages"] = result["followers"].total_pages
      render json: result, include: [:photo], status: :ok
    else
      render json: {message: "Error: Bad request"}, status: 400
    end
  end

  def editable_events
    events = Event.editable_events(current_user[:id], params[:page]).items(params[:page])
    render json: {
             events: events,
             total_pages: events.total_pages,
           }, include: [:research_group]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :lastname, :username, :professional_profile, :email, :phone, :office, :cvlac_link, :career_id, :user_type, :password, :password_confirmation, :picture)
  end

  def authorize_update
    unless current_user.is_admin? || is_current?
      render_unauthorize
    end
  end

  def is_current?
    return current_user.id.to_s == params[:id].to_s
  end
end
