class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
      render file: "/public/404.html", status: 404
    # raise ActionController::RoutingError.new('Not Found')
  end
end
