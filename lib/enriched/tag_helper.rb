module Enriched::TagHelper
  def iframe_tag(opts = {})
    tag :iframe, opts
  end

  def image_tag(opts = {})
    tag :img, opts
  end

  private

  def tag(name, opts = {})
    opts = opts.map { |k,v| "#{k}=\"#{v}\"" }.join(' ')
    "<#{name} #{opts}>"
  end
end
