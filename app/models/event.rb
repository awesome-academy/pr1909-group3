# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :polls
  has_many :questions
  has_many :notes
  has_many :invitations
  has_many :documents

  validates :name, length: { minimum: 5 }

  enum privacy: { low: 0, medium: 1, high: 2 }

  # Su dung trong controller show
  def timeline
    # Timeline o day chua duoc su dung
    timeline = polls.includes(:options).actived.to_a + notes.actived.to_a + questions.includes(:answers).actived.to_a
    timeline.sort! { |a, b| b[:starts_on] <=> a[:starts_on] }
  end

  def self.generate_code
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...10).map { o[rand(o.length)] }.join
  end
end
