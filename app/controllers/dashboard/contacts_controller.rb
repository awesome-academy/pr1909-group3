class Dashboard::ContactsController < Dashboard::DashboardController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = current_user.contacts.search(params[:search]).page(params[:page]).per(10)
  end

  def show; end

  def new
    @contact = current_user.contacts.build
  end

  def edit; end

  def create
    @contact = current_user.contacts.build(contact_params)
    @contact.save
  end

  def update
    @contact.update(contact_params)
  end

  def destroy
    @contact.destroy
  end

  # Su dung gem activerecord-import
  def import
    if !params[:file].present?
      flash[:danger] = t(".not_found")
    else
      Contact.import params[:file], current_user.id
      flash[:success] = t(".success")
    end
    redirect_to dashboard_root_path
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone)
  end
end
