require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recette'

class UsersController < ApplicationController

  before_action :find_user

  def favorite
    found = false
    @user.my_favorites.each do |favorite_array|
      if favorite_array[0] == params["title"]
          @user.my_favorites.delete(favorite_array)
          found = true
          if @user.save
            flash[:status] = :success
            flash[:message] = "#{params["title"]} was deleted from your favorites"
          else
            flash[:status] = :failure
            flash[:message] = "#{params["title"]} couldn't be deleted from your favorites"
          end
      end
    end
    if found == false
      @user.my_favorites << [params["title"], params["uri"], params["image"]]
      if @user.save
        flash[:status] = :success
        flash[:message] = "#{params["title"]} was added to your favorites"
      else
        flash[:status] = :failure
        flash[:message] = "#{params["title"]} couldn't be added to your favorites"
      end
    end
    return redirect_back fallback_location: root_path
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:status] = :failure
      flash[:message] = "Invalid request"
      return redirect_back fallback_location: root_path
    end
  end
end
