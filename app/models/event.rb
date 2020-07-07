class Event < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :notes
  has_many :invitations
  has_many :questions

  validates :name, length: { minimum: 5 }

  enum privacy: { low: 0, medium: 1, hight: 2 }

  def timeline
    timeline = notes.actived.to_a + questions.includes(:answers).actived.to_a
    timeline.sort! { |a, b| b[:starts_on] <=> a[:starts_on] }
  end

  def self.generate_code
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...10).map { o[rand(o.length)] }.join
  end
end
