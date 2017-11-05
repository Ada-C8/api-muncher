class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale, :is_spanish

  def is_spanish
    # @spanish = params[:locale] == "es" ? true : false
    @spanish = I18n.locale == :es ? true : false
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end
end
