class PhotosController < ApplicationController
  before_action :authenticate_user
  before_action :set_photo, only: [:show, :update, :destroy]

  # GET /photos
  def index
    @photos = Photo.all

    render json: @photos, include: []
  end

  # GET /photos/1
  def show
    if @photo.errors.any?
      render json: @photo.errors.messages
    else
      render json: @photo, include: []
    end  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      render json: @photo, status: :created, location: @photo, include: []
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render json: @photo, include: []
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  def destroy
    if @photo.destroy
      render json: @photo, include: []
    else
      render json: @photo.errors, status: 500
    end  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:link, :type_imageable)
    end
end
