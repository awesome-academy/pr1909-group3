# frozen_string_literal: true

class Note < ApplicationRecord
  include UpdateAttributeSupport
  include TimeLineUpdate
  belongs_to :event

  validates :title, presence: true, length: { minimum: 5 }
end
