class Question < ApplicationRecord
  include UpdateAttributeSupport
  include TimeLineUpdate

  validates :title, presence: true,
                    length: { minimum: 5 }

  belongs_to :event
  belongs_to :participant, optional: true
  has_many :answers, dependent: :destroy
end
