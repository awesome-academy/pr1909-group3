class CustomersController < ApplicationController
  before_action :get_user, only: [:index, :show, :edit]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :phone, :address)
  end
end
