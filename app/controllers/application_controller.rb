class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def render_404
    render file: "/app/views/layouts/_not_found.html.erb", status: 404
  end
end
