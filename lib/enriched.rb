require 'rails-html-sanitizer'
require 'enriched/version'
require 'enriched/tag_helper'
require 'enriched/sanitizer'
require 'enriched/url_replacer'
require 'enriched/url'
require 'enriched/youtube'
require 'enriched/vimeo'
require 'enriched/image'

module Enriched

  def self.HTML(text, opts = {})
    text = Enriched::Sanitizer.new(text, opts).call
    # opts[:width] ||= 500
    # opts[:height] ||= 200
    text = Enriched::UrlReplacer.new(text, opts).call
    text.respond_to?(:html_safe) ? text.html_safe : text
  end

end
