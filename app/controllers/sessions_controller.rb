require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recette'

class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      @user = User.find_by(email: auth_hash[:info][:email])

      if @user.nil?
        @user = User.from_auth_hash(auth_hash, auth_hash['provider'])
        if @user.save
          session[:user_id] = @user.id
          flash[:status] = :success
          flash[:message] = "Logged in successfully"
        else
          flash[:status] = :failure
          flash[:message] = "Unable to save user"
        end
      else
        if params[:provider] == @user.provider
          session[:user_id] = @user.id
          flash[:status] = :success
          flash[:message] = "Logged in successfully"
        else
          params[:provider] == "google_oauth2" ? pretty_provider = "Google" : pretty_provider = params[:provider].capitalize

          flash[:status] = :failure
          flash[:message] = "You already own an account through #{pretty_provider}."
        end
      end
    else
      flash[:status] = :failure
      flash[:message] = "Could not log in"
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "You successfully logged out."
    redirect_to root_path
  end

end
