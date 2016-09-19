require 'spec_helper'

describe Enriched::Youtube do
  let(:youtube) { described_class.new('https://www.youtube.com/watch?v=_-MJqF-NIsc') }

  describe '#id' do
    it 'returns the correct id for different formats' do
      [
        'https://www.youtube.com/watch?v=_-MJqF-NIsc',
        'https://youtu.be/_-MJqF-NIsc',
        'https://youtu.be/_-MJqF-NIsc?rel=0',
        'https://www.youtube.com/embed/_-MJqF-NIsc',
        'https://www.youtube-nocookie.com/embed/_-MJqF-NIsc',
        'https://www.youtube.com/watch?v=_-MJqF-NIsc&rel=0',
        'https://www.youtube-nocookie.com/embed/_-MJqF-NIsc?rel=0',
      ].each do |url|
        expect(described_class.new(url).id).to eq '_-MJqF-NIsc'
      end
    end
  end

  describe '#process' do
    it 'returns the given url if not a youtube one' do
      expect(described_class.new('foobar').process).to eq 'foobar'
    end

    it 'returns iframe tag' do
      result = described_class.new('https://youtu.be/_-MJqF-NIsc', youtube: { origin: 'foo' }).process
      expect(result).to include '<iframe'
      expect(result).to include 'src="https://www.youtube.com/embed/_-MJqF-NIsc'
    end

    it 'returns the url if youtube is disabled' do
      result = described_class.new('https://youtu.be/_-MJqF-NIsc', youtube: false).process
      expect(result).to eq 'https://youtu.be/_-MJqF-NIsc'
    end

    it 'returns preview image tag when set to preview' do
      result = described_class.new('https://youtu.be/_-MJqF-NIsc', youtube: { preview: true }).process
      expect(result).to include '<img'
      expect(result).to include 'src="https://img.youtube.com/vi/_-MJqF-NIsc/0.jpg'
    end

    it 'returns links to the given url for previews' do
      result = described_class.new('https://youtu.be/_-MJqF-NIsc', youtube: { preview: 'http://foo.bar' }).process
      expect(result).to eq '<a href="http://foo.bar"><img src="https://img.youtube.com/vi/_-MJqF-NIsc/0.jpg" /></a>'
    end
  end
end
