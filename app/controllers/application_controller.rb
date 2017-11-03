class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_spanish
    @spanish = params[:lang] == "es" ? true : false
  end
end
