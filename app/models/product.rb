class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products

  # Validates
  validates :product_name, presence: true, length: { maximum: Settings.product.product_name.max_length }
  validates :detail, length: {
    minimum: Settings.product.detail.min_length,
    maximum: Settings.product.detail.max_length,
  }
  validates :quantity, numericality: { greater_than_or_equal: 0, only_integer: true }
  validates :price, numericality: { greater_than_or_equal: 0, only_integer: true }

  # Scope
  scope :order_option, ->(option) { order(option => :DESC) }
  scope :load_category, ->(ids) { where category_id: ids if ids.any? }
  scope :find_ids, -> (ids) { where id: ids }
  scope :latest, lambda {
                   where('created_at >= created_at or updated_at >= updated_at',
                         created_at: Time.zone.now - 15.days, updated_at: Time.zone.now - 3.days)
                 }

  attr_accessor :amount_added

  def get_total_price
    amount_added.present? ? price * amount_added : price
  end
end
