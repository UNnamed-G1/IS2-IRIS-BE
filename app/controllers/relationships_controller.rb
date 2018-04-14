class RelationshipsController < ApplicationController
  before_action :authenticate_user, except: %i[index show]
  before_action :authorize_as_admin, only: [:delete]
  before_action :set_relationship, only: %i[show update destroy]

  # GET /relationships
  def index
    @relationships = Relationship.all
    render json: @relationships, include: []
  end

  # GET /relationships/1
  def show
    if @relationship.errors.any?
      render json: @relationship.errors.messages
    else
      render json: @relationship, include: []
    end
  end

  # POST /relationships
  def create
    @relationship = Relationship.new(relationship_params)

    if @relationship.save
      render json: @relationship, status: :created, location: @relationship, include: []
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /relationships/1
  def update
    if @relationship.update(relationship_params)
      render json: @relationship, include: []
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /relationships/1
  def destroy
    if @relationship.destroy
      render json: @relationship, include: []
    else
      render json: @relationship.errors, status: 500
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_relationship
    @relationship = Relationship.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def relationship_params
    params.require(:relationship).permit(:follower_id, :followed_id)
  end
end
