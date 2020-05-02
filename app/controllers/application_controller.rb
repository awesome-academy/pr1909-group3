class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ProductsHelper
  include CartsHelper
  include OrdersHelper
  include UsersHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_search

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :name, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_search
    @q = Product.ransack(params[:q])
    @product = @q.result
  end
end
