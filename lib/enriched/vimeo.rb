class Enriched::Vimeo
  include Enriched::TagHelper

  URL_FORMATS = {
    regular: /^https?:\/\/(?:www\.|player\.)?vimeo.com\/(?:channels\/(?:\w+\/)?|groups\/([^\/]*)\/videos\/|album\/(?<id>\d+)\/video\/|video\/|)(?<id>\d+)(?:$|\/|\?)/,
  }

  attr_accessor :url, :opts

  def initialize(url, opts = {})
    @url = url
    @opts = build_vimeo_opts(opts)
  end

  def process
    id or return url

    if opts[:disabled]
      url
    else
      opts[:preview] ? preview : iframe
    end
  end

  def id
    @id ||= URL_FORMATS.values.map do |format_regex|
      url.to_s[format_regex, 'id']
    end.compact.first
  end

  private

  def build_vimeo_opts(opts)
    return { disabled: true } if opts[:vimeo] == false
    result = Hash(opts[:vimeo])
    result[:width] ||= opts[:width]
    result[:height] ||= opts[:height]
    result
  end

  def preview
    src = "https://i.vimeocdn.com/video/#{id}_#{opts[:width]}x#{opts[:height]}.webp"
    src = "https://i.vimeocdn.com/filter/overlay?src=#{src}&src=http://f.vimeocdn.com/p/images/crawler_play.png"
    link_tag image_tag(src: src), href: opts[:preview]
  end

  def iframe
    src = "https://player.vimeo.com/video/#{id}"
    iframe_tag(
      type:                  'text/html',
      width:                 opts[:width],
      height:                opts[:height],
      src:                   src,
      frameborder:           0,
      webkitallowfullscreen: 'webkitallowfullscreen',
      mozallowfullscreen:    'mozallowfullscreen',
      allowfullscreen:       'allowfullscreen'
    )
  end
end
