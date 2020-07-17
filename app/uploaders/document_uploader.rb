require 'image_processing/mini_magick'

class DocumentUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :add_metadata
  # Plugin determine_mime_type cho phép xác định và lưu trữ kiểu file từ nội dung file đã phân tích
  plugin :determine_mime_type
  # Plugin remove_attachment cho phép xóa các file đính kèm bằng một checkbox trên form
  plugin :remove_attachment
  # Plugin store_dimensions lấy và lưu trữ kích thước các chiều của ảnh bằng gem fastimage, tránh việc gặp phải file ảnh quá lớn
  # plugin :store_dimensions
  # Plugin validation_helpers cung cấp các hàm helper giúp validate file
  plugin :validation_helpers
  # Plugin pretty_location giúp tạo một cấu trúc thư mục đẹp để lưu các file tải lên
  plugin :pretty_location
  # Cho phép định nghĩa các processing cho một hành động cụ thể
  plugin :processing
  # Plugin versions cho phép xử lý theo version, bằng cách trả về một Hash chứa các file sau khi xử lý
  plugin :versions
  # Plugin delete_promoted thực hiện xóa các file sau khi sau khi được tải lên S3 thành công
  plugin :delete_promoted
  # Plugin delete_raw tự đông xóa các file thô sau khi được xử lý
  plugin :delete_raw
  # Plugin cached_attachment_data giữ lại cache file sau khi hiện lại form, giúp cho người dùng không phải upload lại nếu gặp lỗi validation
  plugin :cached_attachment_data
  # Plugin recache giúp sử dụng các version ngay lập tức
  plugin :recache


  # Define validations
  Attacher.validate do
    validate_max_size 15.megabytes, message: 'is too large (max is 15 MB)'
    # validate_mime_type_inclusion ['image/jpeg', 'image/png', 'image/gif', 'doc/xlsx', 'doc/odt']
  end


  # Sử dụng phiên bản :original và :thumbnail ngay lập tức
  # process(:recache) do |io|
  #   {
  #     original: io,
  #     thumbnail: resize_to_fill!(io.download, 600, 600)
  #   }
  # end

  # Thực hiện các phiên bản khác ở background
  process(:store) do |io|
    original = io[:original].download

    {
      # Original
      sm: resize_to_fit(original, 350, 350),
      md: resize_to_fit(original, 600, 600),
      lg: resize_to_fit(original, 1200, 1200),

      # Squares
      sm_square: resize_to_fill(original, 350, 350),
      md_square: resize_to_fill(original, 600, 600),
      lg_square: resize_to_fill(original, 1200, 1200),
    }
  end
end
