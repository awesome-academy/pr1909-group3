class Invitation < ApplicationRecord
  attr_accessor :invitation_token

  belongs_to :event

  scope :confirmed, -> { where confirm: true }
  scope :unconfirmed, -> { where confirm: false }
  before_create :create_invitation_digest

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  class << self
    def import(file, event_id)
      spreadsheet = open_spreadsheet file
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by(name: row['name'], email: row['email']) || new
        product.event_id = event_id
        product.attributes = row.to_hash.slice(*row.to_hash.keys)
        product.save!
      end
    end

    def open_spreadsheet(file)
      case File.extname file.original_filename
      when '.csv' then Roo::CSV.new file.path
      when '.xls' then Roo::Excel.new file.path
      when '.xlsx' then Roo::Excelx.new file.path
      else raise file.original_filename
      end
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  private

  def create_invitation_digest
    self.invitation_token  = Invitation.new_token
    self.invitation_digest = Invitation.digest(invitation_token)
  end
end
