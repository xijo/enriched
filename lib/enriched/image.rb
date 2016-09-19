class Enriched::Image
  include Enriched::TagHelper

  MATCHER = /\.(jpg|jpeg|gif|png|bmp)([#?]|\z)/

  attr_accessor :url, :opts

  def initialize(url, opts = {})
    @url = url
    @opts = extract_opts(opts)
  end

  def process
    url =~ MATCHER or return url
    opts[:disabled] ? url : image_tag(src: url)
  end

  private

  def extract_opts(opts)
    return { disabled: true } if opts[:image] == false
    result = Hash(opts[:image])
    result[:width] ||= opts[:width]
    result[:height] ||= opts[:height]
    result
  end
end
