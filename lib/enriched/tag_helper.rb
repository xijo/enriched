module Enriched::TagHelper
  def iframe_tag(attrs = {})
    tag :iframe, attrs
  end

  def image_tag(attrs = {})
    tag :img, attrs
  end

  # Return content if no href was given, an empty link should not be there.
  def link_tag(content, attrs = {})
    attrs[:href].is_a?(String) or return content
    content_tag :a, content, attrs
  end

  private

  def content_tag(name, content, attrs = {})
    "<#{name} #{join_attributes(attrs)}>#{content}</#{name}>"
  end

  def tag(name, attrs = {})
    "<#{name} #{join_attributes(attrs)} />"
  end

  def join_attributes(attrs)
    attrs.map { |k,v| "#{k}=\"#{v}\"" }.join(' ')
  end
end
