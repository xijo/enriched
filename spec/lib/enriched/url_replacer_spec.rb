require 'spec_helper'

describe Enriched::UrlReplacer do
  describe '#call' do
    let(:input)  { '' }
    let(:opts)   { {} }
    let(:result) { Enriched::UrlReplacer.new(input, opts).call }

    it 'processes multiple urls' do
      input.replace 'Ein http://te.xt mit mehreren https://urls.drin'
      expect(Enriched::URL).to receive(:new).twice.and_call_original
      expect(result).to eq input
    end

    it 'ignores unknown urls' do
      input.replace 'Normal url http://foo.bar'
      expect(result).to eq input
    end

    it 'ignores urls that are part of a tag already' do
      input.replace '<foo src="https://www.youtube.com/embed/zJORwxt9O6o" />'
      expect(result).to eq input
    end
  end
end
