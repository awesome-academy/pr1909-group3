module UsersHelper
  def load_user_roles
    User.roles.map { |k, _v| [k, k] }
  end

  def check_del_user(user)
    orders = user.orders.processing
    orders.each(&:cancelled!)
  end

  def current_user?(user)
    user == current_user
  end
end
