class Event < ApplicationRecord
  belongs_to :user

  validates :name, length: { minimum: 5 }

  enum privacy: { low: 0, medium: 1, hight: 2 }

  # def timeline
  #   timeline.sort! { |a, b| b[:starts_on] <=> a[:starts_on] }
  # end

  def self.generate_code
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...10).map { o[rand(o.length)] }.join
  end
end
