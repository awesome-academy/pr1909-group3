class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum status: { "new": 0, "processing": 1, "success": 2 }
end
