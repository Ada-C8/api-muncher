class UsersController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']
    p @auth_hash
    @user = User.find_by(uid: @auth_hash['uid'],provider: @auth_hash['provider'])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}!"
    else
      @user = User.new(uid: @auth_hash['uid'],
      provider: @auth_hash['provider'],
      name: @auth_hash['info']['name'],
      email:@auth_hash['info']['email'])
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

  def favorite
    fav = Favorite.new(user_id: session[:user_id], uri: params[:uri], label: params[:label],image: params[:image], source: params[:source] )

    if fav.save
      flash[:success] = "Added to your favorites!"
      redirect_to recipe_path(params[:uri])
    else
      flash[:failure] = "Unable to favorite recipe."
      redirect_to recipe_path(params[:uri])
    end
  end

  def show
    unless @user.nil?
      if @user.id.to_s == params[:id].to_s
        @user = User.find_by(id: session[:user_id])
        @favorites = @user.favorites.paginate(:page => params[:page], :per_page => 6)
      else
        flash[:failure] = "You can't view another users information"
        redirect_to root_path, status: :bad_request
      end
    else
      flash[:failure] = "You must be logged in"
      redirect_to root_path, status: :bad_request
    end
  end
end
