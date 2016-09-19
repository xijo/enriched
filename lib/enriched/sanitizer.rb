class Enriched::Sanitizer
  attr_accessor :body, :opts

  def initialize(body, opts = {})
    @body = body.to_s
    @opts = opts
  end

  def call
    sanitize
    body
  end

  private

  def sanitize
    whitelist_css_properties('text-align', 'text-decoration') do
      sanitizer = Rails::Html::WhiteListSanitizer.new
      @body     = sanitizer.sanitize(body,
        tags:       %w[ strong b em i u span ul li p a img br ],
        attributes: %w[ style title href target src height width rel ]
      )
    end
  end

  def whitelist_css_properties(*values, &block)
    old_values = Loofah::HTML5::WhiteList::ALLOWED_CSS_PROPERTIES
    Loofah::HTML5::WhiteList::ALLOWED_CSS_PROPERTIES.replace(values)
    block.call
  ensure
    Loofah::HTML5::WhiteList::ALLOWED_CSS_PROPERTIES.merge(old_values)
  end
end
