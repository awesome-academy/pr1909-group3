# frozen_string_literal: true

class Poll < ApplicationRecord
  include UpdateAttributeSupport
  include TimeLineUpdate

  belongs_to :event
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true

  validates :title, presence: true
  validates :multi_vote, numericality: { greater_than: 0 }

  def normalized_votes_for(option)
    votes_summary == 0 ? 0 : (option.votes_count.to_f / votes_summary) * 100
  end

  def votes_summary
    options.inject(0) { |summary, option| summary + option.votes_count }
  end
end
