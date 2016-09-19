class Enriched::UrlReplacer
  URL_MATCHER = /\<[^\<\>]+\>|(https?:\/\/|www\.)[^\>\<\s]+/
  attr_accessor :body, :opts

  def initialize(body, opts = {})
    @body = body
    @opts = opts
  end

  def call
    body.gsub(URL_MATCHER) { |url| Enriched::URL.new(url, opts).to_s }
  end
end
