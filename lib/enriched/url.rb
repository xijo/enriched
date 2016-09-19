class Enriched::URL
  attr_accessor :url, :opts

  def initialize(url, opts = {})
    @url  = url.to_s
    @opts = opts
  end

  def to_s
    part_of_tag? and return url
    url = Enriched::Youtube.new(url_with_schema, opts).process
  end

  private

  def part_of_tag?
    url.start_with? '<'
  end

  def url_with_schema
    url.start_with?('http') ? url : 'http://' << url
  end
end
