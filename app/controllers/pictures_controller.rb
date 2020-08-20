class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :check_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @picture.save
          PictureMailer.contact_mail(@picture).deliver
          format.html { redirect_to @picture, notice: '新規投稿しました！' }
          # format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new }
          # format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: '投稿しました！' }
        # format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        # format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: '削除しました！' }
      # format.json { head :no_content }
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end
  def picture_params
    params.require(:picture).permit(:image, :image_cache, :id, :content)
  end
  def check_picture
    if current_user.id != @picture.user.id
      redirect_to pictures_path, notice: '権限がありません'
    end
  end
end
