class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name
  self.inheritance_column = nil
  def url_content
    url(:content)
  end
end
