class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    unless current_user.id == @user.user_id
      redirect_to pictures_path, notice: '他人のプロフィールは編集できません'
    end
  end

  def update
    if params[:back]
      render :edit
    else
      if @user.update(user_params)
        redirect_to user_pash(@user.id), notice: '編集しました'
      else
        render :edit
      end
    end
  end

  def show
  end

  def confirm
    @user = current_user.users.build(user_params)
    render :new if @user.invalid?
  end

  def destroy
    unless current_user.id == @user.user_id
      redirect_to pictures_path, notice: '他人のユーザー情報は削除できません'
    else
      @user.destroy
      redirect_to new_user_path, notice: 'ユーザー情報を削除しました'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :image, :image_cache, :user_name)
  end
end
