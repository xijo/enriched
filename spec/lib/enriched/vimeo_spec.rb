require 'spec_helper'

describe Enriched::Vimeo do
  describe '#id' do
    it 'returns the correct id for different formats' do
      [
        'https://vimeo.com/182762845',
        'http://vimeo.com/182762845',
        'https://www.vimeo.com/182762845',
        'http://www.vimeo.com/182762845',
        'https://vimeo.com/channels/182762845',
        'http://vimeo.com/channels/182762845',
        'https://vimeo.com/groups/name/videos/182762845',
        'http://vimeo.com/groups/name/videos/182762845',
        'https://vimeo.com/album/2222222/video/182762845',
        'http://vimeo.com/album/2222222/video/182762845',
        'https://vimeo.com/182762845?param=test',
        'http://vimeo.com/182762845?param=test',
      ].each do |url|
        expect(described_class.new(url).id).to eq '182762845'
      end
    end
  end

  describe '#process' do
    it 'returns the given url if not a vimeo one' do
      expect(described_class.new('foobar').process).to eq 'foobar'
    end

    it 'returns iframe tag' do
      result = described_class.new('https://vimeo.com/182762845').process
      expect(result).to include '<iframe'
      expect(result).to include 'src="https://player.vimeo.com/video/182762845'
    end

    it 'returns the url if vimeo is disabled' do
      result = described_class.new('https://vimeo.com/182762845', vimeo: false).process
      expect(result).to eq 'https://vimeo.com/182762845'
    end

    it 'returns preview image tag when set to preview' do
      result = described_class.new('https://vimeo.com/182762845', vimeo: { preview: true }).process
      expect(result).to include '<img'
      expect(result).to include 'src="https://i.vimeocdn.com/filter/overlay'
    end
  end
end
