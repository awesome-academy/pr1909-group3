class Participant < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event
  has_many :votes
  has_many :answers
  has_many :questions

  after_create :create_degit

  validates :name, presence: true, allow_blank: false

  attr_accessor :participant_token

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def update_admin(event, list_participant_id)
      ActiveRecord::Base.transaction do
        event.participants.update_all(is_admin: false)
        event.participants.where(id: list_participant_id).update_all(is_admin: true)
      end
    end
  end

  def create_degit
    self.participant_token = Participant.new_token
    update_attribute(:authencode_app, Participant.digest(participant_token))
  end

  def event_authenticated?(remember_token)
    BCrypt::Password.new(authencode_app).is_password?(remember_token)
  end

  def voted_for?(poll)
    option_ids = poll.options.pluck(:id)
    poll_votes = votes.where(option_id: option_ids)
    poll_votes.size >= poll.multi_vote
  end
end
