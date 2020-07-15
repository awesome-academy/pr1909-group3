class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include ApplicationHelper
  include EventsHelper
  include TimelineHelper

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
