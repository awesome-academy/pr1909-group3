class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  before_save :update_subtotal

  enum status: { "init": 0, "processing": 1, "success": 2 }

  def get_subtotal
    order_details.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
