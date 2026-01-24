# app/controllers/follows_controller.rb
class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_user

  def create
    if current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_to public_profile_path(username: @user.username) }
        format.turbo_stream
      end
    end
  end

  def destroy
    current_user.unfollow(@user)
    
    respond_to do |format|
      format.html { redirect_to public_profile_path(username: @user.username) }
      format.turbo_stream
    end
  end

  def followers
    # Só o próprio usuário ou usuários logados podem ver seguidores
    if user_signed_in? && (current_user == @user || current_user.following?(@user))
      @followers = @user.followers
    else
      redirect_to public_profile_path(username: @user.username), alert: "Você não tem permissão para ver isso."
    end
  end

  def following
    # Só o próprio usuário ou usuários logados podem ver quem ele segue
    if user_signed_in? && (current_user == @user || current_user.following?(@user))
      @following = @user.following
    else
      redirect_to public_profile_path(username: @user.username), alert: "Você não tem permissão para ver isso."
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end
end