class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_search
  before_action :load_categories
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_search
    @q = Product.ransack(params[:q])
    @product = @q.result
  end

  def load_categories
    @categories = Category.all
    @cates_hash = {}
    @categories.each do |category|
      id = category.id
      name = category.category_name
      @cates_hash.store(name, id)
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :name, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
