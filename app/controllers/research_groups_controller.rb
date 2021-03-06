class ResearchGroupsController < ApplicationController
  before_action :authenticate_user, except: %i[index show news]
  before_action :authorize_as_admin, only: %i[destroy create]
  before_action :authorize_update, only: [:update]
  before_action :set_research_group, only: %i[show update destroy]

  # GET /research_groups
  def index
    research_groups = ResearchGroup.items(params[:page])
    render json: {
             research_groups: research_groups,
             total_pages: research_groups.total_pages,
           }, include: [:photo]
  end

  # GET /research_groups/1
  def show
    if @research_group.errors.any?
      render json: @research_group.errors.messages
    else
      render json: @research_group, include: [:members, "members.user", "members.user.photo", :publications, :events, "events.photos", :research_subjects, :photo] # This is an example of associations that are brought
    end
  end

  # POST /research_groups
  def create
    @research_group = ResearchGroup.new(research_group_params)

    if @research_group.save
      picture = params[:picture]
      @research_group.update(photo: Photo.create_photo(picture, @research_group)) if picture
      render json: @research_group, status: :created, location: @research_group, include: [:photo]
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /research_groups/1
  def update
    if @research_group.update(research_group_params)
      picture = params[:picture]
      if @research_group.photo
        @research_group.photo.update(picture: picture) if picture
      else
        @research_group.update(photo: Photo.create_photo(picture, @research_group)) if picture
      end
      render json: @research_group, include: [:photo]
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /research_groups/1
  def destroy
    if @research_group.destroy
      render json: @research_group, include: []
    else
      render json: @research_group.errors, status: 500
    end
  end

  # GET /research_groups/news
  def news
    research_groups = ResearchGroup.news
    fields = %i[name description updated_at]
    render json: research_groups, fields: fields, include: [:photo], status: :ok
  end

  # GET /research_groups/requested
  def requested
    research_groups = ResearchGroup.Solicitado.items(params[:page])
    render json: {
             research_groups: research_groups,
             total_pages: research_groups.total_pages,
           }, include: [:photo]
  end

  # GET /research_groups/accepted
  def accepted
    research_groups = ResearchGroup.Aceptado.items(params[:page])
    render json: {
             research_groups: research_groups,
             total_pages: research_groups.total_pages,
           }, include: [:photo]
  end

  def get_events
    research_group = ResearchGroup.find(params[:id])
    events_by_rg = research_group.get_events().items(params[:page])
    render json: {
             events: events_by_rg,
             total_pages: events_by_rg.total_pages,
           }, fields: %i[id name topic event_type], include: []
  end

  def search_rgs_by_name
    rgs_by_name = ResearchGroup.search_rgs_by_name(params[:keywords]).items(params[:page])
    render json: {
             research_groups: rgs_by_name,
             total_pages: rgs_by_name.total_pages,
           }, fields: %i[id name], include: []
  end

  def search_rgs_by_current_user
    rgs_by_curr_user = ResearchGroup.get_rgs_by_user(current_user.id)
    render json: rgs_by_curr_user, fields: %i[id name], include: []
  end

  def search_rgs_by_class
    rgs_by_class = ResearchGroup.search_rgs_by_class(params[:cl_type]).items(params[:page])
    render json: {
             research_groups: rgs_by_class,
             total_pages: rgs_by_class.total_pages,
           }, fields: %i[id name], include: []
  end

  def search_rgs_by_department
    rgs_by_department = ResearchGroup.search_rgs_by_dept(params[:id]).items(params[:page])
    render json: {
             research_groups: rgs_by_department,
             total_pages: rgs_by_department.total_pages,
           }, fields: %i[id name], include: []
  end

  # POST /research_groups/:id/add_users
  def add_users
    users = params[:users]
    research_group = ResearchGroup.find(params[:id])
    users.each do |user|
      research_group.add_member(User.find(user[:id]), user[:member_type])
      ResearchGroupMailer.delay.welcome_research_group(current_user, research_group)
    end
    render json: {"message": "Miembros agregados satisfactoriamente."}, status: :ok
  end

  # PUT /research_groups/:id/user_as_retired?user_id=1
  def change_user_as_retired
    user_id = params[:user_id]
    research_group = ResearchGroup.find(params[:id])
    research_group.change_state_user(user_id, :Retirado)
    render json: research_group, status: :ok
  end

  # PUT /research_groups/:id/user_as_active?user_id=1
  def change_user_as_active
    user_id = params[:user_id]
    research_group = ResearchGroup.find(params[:id])
    research_group.change_state_user(user_id, :Activo)
    render json: research_group, status: :ok
  end

  # PUT /research_groups/:id/user_as_lider?user_id=1
  def change_user_as_lider
    user_id = params[:user_id]
    research_group = ResearchGroup.find(params[:id])
    research_group.change_type_user(user_id, :Líder)
    render json: research_group, status: :ok
  end

  # PUT /research_groups/:id/accept_request?user_id=1
  # PUT /research_groups/:id/user_as_member?user_id=1
  def change_user_as_member
    user_id = params[:user_id]
    research_group = ResearchGroup.find(params[:id])
    research_group.change_type_user(user_id, :Miembro)
    render json: research_group, status: :ok
  end

  # DELETE /research_groups/:id/reject_request?user_id=1
  def remove_user
    user = User.find(params[:user_id])
    research_group = ResearchGroup.find(params[:id])
    research_group.remove_user(user)
    render json: research_group, status: :ok
  end 

  # POST /research_groups/request_create
  def request_create
    @research_group = ResearchGroup.new(research_group_params)
    @research_group.update(state: :Solicitado)

    if @research_group.save
      picture = params[:picture]
      @research_group.update(photo: Photo.create_photo(picture, @research_group)) if picture
      @research_group.add_member(User.find(current_user.id), :Líder)
      render json: @research_group, status: :created, location: @research_group, include: [:photo]
    else
      render json: @research_group.errors, status: :unprocessable_entity
    end
  end

  # PUT /research_groups/:id/accept_new_group
  def accept_new_group
    research_group = ResearchGroup.find(params.require(:id))

    if research_group.update(state: :Aceptado)
      render json: {"message": "El grupo ha sido aceptado satisfactoriamente."}, status: :ok
    else
      render json: {"error": "Error no especificado."}, status: 400
    end
  end

  # PUT /research_groups/:id/reject_new_group
  def reject_new_group
    research_group = ResearchGroup.find(params.require(:id))

    if research_group.update(state: :Rechazado)
      render json: {"message": "El grupo ha sido rechazado."}, status: :ok
    else
      render json: {"error": "Error no especificado."}, status: 400
    end
  end

  # GET /research_groups/:id/available_users?keywords=words
  def available_users_to_add
    research_group = ResearchGroup.find(params.require(:id))
    keywords = params[:keywords]
    if keywords.empty?
      users = User.order("RANDOM()").limit(10)
    else
      users = research_group.search_available_users(keywords.upcase)
    end
    render json: users, fields: [:id, :full_name, :username, :user_type], include: [:photo], each_serializer: UserSerializer, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_research_group
    @research_group = ResearchGroup.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def research_group_params
    params.require(:research_group).permit(:name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, :url, :state)
  end

  def authorize_update
    unless current_user.is_lider_of_research_group?(params[:id]) || current_user.is_admin?
      render_unauthorize
    end
  end
end
