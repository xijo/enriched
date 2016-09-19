require 'spec_helper'

describe Enriched::Sanitizer do
  describe '#call' do
    let(:input) { '' }
    let(:result) { Enriched::Sanitizer.new(input).call }

    it 'removes forbidden tags' do
      input.replace '<script>alert(42)</script'
      expect(result).to eq 'alert(42)'
    end

    it 'removes stale tags' do
      input.replace '</p>'
      expect(result).to eq ''
    end

    it 'adds missing closing tags' do
      input.replace '<p>foobar'
      expect(result).to eq '<p>foobar</p>'
    end

    it 'sanitizes css' do
      input.replace '<span style="text-align: center; color: green">foo</span>'
      expect(result).to eq '<span style="text-align: center;">foo</span>'
    end
  end
end
