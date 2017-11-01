class UsersController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth_hash['uid'],provider: @auth_hash['provider'])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}!"
    else
        @user = User.new(uid: @auth_hash['uid'],
        provider: @auth_hash['provider'], name: @auth_hash['info']['name'], name: @auth_hash['info']['name'], email:@auth_hash['info']['email'])
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.name}!"
      else
        flash[:failure] = "Unable to log in!"
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
