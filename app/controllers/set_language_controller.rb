class SetLanguageController < ApplicationController
  def en
    I18n.locale = :en
    set_session_and_redirect
  end

  def vi
    I18n.locale = :vi
    set_session_and_redirect
  end

  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_back fallback_location: root_path
  end
end
