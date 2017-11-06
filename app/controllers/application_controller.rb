class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def disable_header_search
    @disable_header_search = true
  end
end
