class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by!(username: params[:username])
    
    if current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_to public_profile_path(username: @user.username) }
        format.turbo_stream
      end
    end
  end

  def destroy
    @user = User.find_by!(username: params[:username])
    
    current_user.unfollow(@user)
    
    respond_to do |format|
      format.html { redirect_to public_profile_path(username: @user.username) }
      format.turbo_stream
    end
  end

  def followers
    @user = User.find_by!(username: params[:username])
    @followers = @user.followers
  end

  def following
    @user = User.find_by!(username: params[:username])
    @following = @user.following
  end
end