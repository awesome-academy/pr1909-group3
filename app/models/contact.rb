class Contact < ApplicationRecord
  belongs_to :user

  validates :name, length: { minimum: 5, maximum: 100 }

  scope :search, ->(key) { where('name LIKE ? OR email LIKE ?', "%#{key}%", "%#{key}%") if key.present? }

  class << self
    def import(file, user_id)
      spreadsheet = open_spreadsheet file
      contacts = []
      old_contacts = Contact.where(user_id: 1).pluck(:email)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        # byebug
        row = Hash[[header, spreadsheet.row(i)].transpose]
        next if old_contacts.include? row['email']
        contact = new
        contact.user_id = user_id
        contact.attributes = row.to_hash.slice(*row.to_hash.keys)
        contacts << contact
      end
      import! contacts
    end

    def open_spreadsheet(file)
      case File.extname file.original_filename
      when '.csv' then Roo::CSV.new file.path
      when '.xls' then Roo::Excel.new file.path
      when '.xlsx' then Roo::Excelx.new file.path
      else raise file.original_filename
      end
    end
  end
end
