require 'spec_helper'

describe Enriched do
  describe '.HTML' do
    it 'calls the sanitizer' do
      expect(Enriched::Sanitizer).to receive(:new).with('foobar', foo: :bar).and_call_original
      Enriched::HTML('foobar', foo: :bar)
    end

    it 'calls the url processor' do
      expect(Enriched::UrlReplacer).to receive(:new).with('foobar', foo: :bar).and_call_original
      Enriched::HTML('foobar', foo: :bar)
    end
  end
end
