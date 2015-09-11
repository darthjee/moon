class QRCodeBuilder
  attr_reader :url, :overlay

  def initialize(url, overlay)
    @url = url
    @overlay = overlay
  end

  def build
    qr_code_image.save(qr_temp_name)
    merged_image.to_blob
  end

  private

  def merged_image
    qr_code_temp_image.composite(overlay_image)
  end

  def qr_code_temp_image
    @qr_code_temp_image = MiniMagick::Image.new(qr_temp_name)
  end

  def qr_temp_name
    @qr_temp_name ||= "tmp/#{SecureRandom.hex(10)}_code.png"
  end

  def qr_code_image
    @qr_code_image ||= RQRCode::QRCode.new(url).to_img.resize(300, 300)
  end

  def overlay_image
    @overlay_image ||= MiniMagick::Image.open(overlay)
  end

end
