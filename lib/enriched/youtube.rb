class Enriched::Youtube
  include Enriched::TagHelper

  URL_FORMATS = {
    regular:          /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=(?<id>[^&]+)/,
    shortened:        /^(https?:\/\/)?(www\.)?youtu.be\/(?<id>[^?]+)/,
    embed:            /^(https?:\/\/)?(www\.)?youtube.com\/embed\/(?<id>[^&]+)/,
    embed_as3:        /^(https?:\/\/)?(www\.)?youtube.com\/v\/(?<id>[^?]+)/,
    embed_cookieless: /^(https?:\/\/)?(www\.)?youtube-nocookie.com\/embed\/(?<id>[^?]+)/,
    chromeless_as3:   /^(https?:\/\/)?(www\.)?youtube.com\/apiplayer\?video_id=(?<id>[^&]+)/
  }

  attr_accessor :url, :opts

  def initialize(url, opts = {})
    @url = url
    @opts = opts
  end

  def process
    id or return url

    case opts[:youtube]
    when :preview, 'preview'
      preview
    when true, nil
      iframe
    else
      url
    end
  end

  def id
    @id ||= URL_FORMATS.values.map do |format_regex|
      url.to_s[format_regex, 'id']
    end.compact.first
  end

  private

  def preview
    image_tag src: "https://img.youtube.com/vi/#{id}/0.jpg"
  end

  def iframe
    query = {
      enablejsapi:    1,
      origin:         origin,
      modestbranding: 1,      # youtube video transparent, not part of controls
      rel:            0,      # don't show "similar" videos at the end
      showinfo:       0,      # disable title on start
      fs:             1,      # enable fullscreen
    }.map { |k,v| "#{k}=#{v}" }.join('&')
    src = "https://www.youtube.com/embed/#{id}?#{query}"
    iframe_tag allowfullscreen: true, type: 'text/html', width: opts[:width], height: opts[:height], src: src, frameborder: 0
  end

  def origin
    if Rails.respond_to?(:application)
      default_url_options = Rails.application.routes.default_url_options
      "#{default_url_options[:protocol]}://#{default_url_options[:host]}"
    else
      opts.fetch(:origin)
    end
  end
end
