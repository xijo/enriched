require 'rails-html-sanitizer'
require 'nokogiri'
require 'enriched/version'
require 'enriched/tag_helper'
require 'enriched/sanitizer'
require 'enriched/url_replacer'
require 'enriched/url'
require 'enriched/youtube'

module Enriched

  def self.HTML(text, opts = {})
    text = Enriched::Sanitizer.new(text, opts).call
    Enriched::UrlReplacer.new(text, opts).call
  end

end
