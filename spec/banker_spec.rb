# frozen_string_literal: true

require 'parser'
require 'banker'

describe Banker do
  let(:safe_examples) do
    [
      Parser.new('spec/fixtures/sys_config.txt').data,
      Parser.new('spec/fixtures/wikipedia_example.txt').data,
      Parser.new('spec/fixtures/youtube_example.txt').data
    ]
  end

  let(:unsafe_example) { Parser.new('spec/fixtures/unsafe.txt').data }

  describe '#safe?' do
    it 'checks whether a system is in a safe state' do
      safe_examples.each do |example|
        expect(Banker.safe?(**example)).to eq(true)
      end

      expect(Banker.safe?(**unsafe_example)).to eq(false)
    end
  end
end
