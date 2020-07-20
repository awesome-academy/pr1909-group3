class Document < ApplicationRecord
  belongs_to :event
  include TimeLineUpdate
  include DocumentUploader[:file]
  include ActionView::Helpers::NumberHelper

  validates :title, presence: true,
            length: {minimum: 5}

  validates :file_data, presence: true

  def file_name
    JSON.parse(file_data)["metadata"]["filename"]
  end

  def file_size
    number_to_human_size(JSON.parse(file_data)["metadata"]["size"])
  end
end
