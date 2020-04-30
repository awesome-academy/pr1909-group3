module CartsHelper
  def load_cookie_cart
    @orders = cookies[:orders].blank? ? {} : JSON.parse(cookies[:orders])
  end

  def save_cookie_cart(orders)
    cookies.permanent[:orders] = JSON.generate orders
  end

  def clear_cart
    save_cookie_cart({})
  end

  def add_product(product_id, quantity = 1)
    product = Product.find_by id: product_id
    if quantity <= 0 || product.nil?
      return flash[:danger] = "Loi"
    end
    load_cookie_cart
    if @orders.key? product_id
      @orders[product_id] += quantity
    else
      @orders[product_id] = quantity
    end
    check_out_stock product, quantity
  end

  def check_out_stock(product, quantity)
    id = product.id.to_s
    if @orders[id] > product.quantity
      @orders[id] = product.quantity
      flash[:warning] = product.product_name + I18n.t("product.out_stock", count: product.quantity)
    else
      flash[:success] = I18n.t("product.added", name: product.product_name, count: quantity)
      save_cookie_cart @orders
    end
  end

  def update_cart(product_id, quantity)
    product = Product.find_by id: product_id
    if quantity <= 0 || product.nil?
      return flash[:danger] = I18n.t("product.add_failed")
    end

    load_cookie_cart
    unless @orders.key? product_id
      return flash[:danger] = I18n.t("product.add_failed")
    end
    @orders[product_id] = quantity
    check_out_stock product, quantity
  end

  def remove_product(product_id)
    load_cookie_cart
    return @orders unless @orders.key?(product_id)

    @orders.delete(product_id)
    save_cookie_cart @orders
  end

  def load_size_cart
    load_cookie_cart
    @orders.size
  end

  def get_total_price(products)
    products.reduce(0) do |sum, p|
      sum + p.get_total_price
    end
  end
end
