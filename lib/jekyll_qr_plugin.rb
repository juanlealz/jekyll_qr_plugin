require "jekyll_qr_plugin/version"
require "jekyll"
require "rqrcode"
require "base64"

module JekyllQrPlugin
  class Error < StandardError; end

  class QRTag < Liquid::Tag
    def initialize(tagName, content, tokens)
      super
      @content = content
    end

    def render(context)
      url = "#{context[@content.strip]}"
      qr = RQRCode::QRCode.new(url)
      img = qr.as_png(size: 80, border_modules: 0)
      b64img = Base64.encode64(img.to_s)
      "data:image/png;base64, #{ b64img }"
    end

    Liquid::Template.register_tag "qr", self
  end
end
