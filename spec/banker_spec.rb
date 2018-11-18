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

  describe '.new' do
    let(:banker) { Banker.new(**safe_examples.first) }

    it 'initializes a system' do
      expect(banker).to_not be_nil
      expect(banker.allocation).to_not be_nil
      expect(banker.max).to_not be_nil
      expect(banker.available).to_not be_nil
    end
  end

  describe '.grant?' do
    let(:banker) { Banker.new(**safe_examples.first) }
    let(:grantable_request) { Vector[1, 0, 2] }
    let(:ungrantable_request) { Vector[9, 9, 9] }

    it 'checks whether a request can be granted' do
      expect(banker.grant?(grantable_request)).to be true
      expect(banker.grant?(ungrantable_request)).to be false
    end
  end

  describe '.safe?' do
    it 'checks whether a system is in a safe state' do
      safe_examples.each do |example|
        expect(Banker.new(**example).safe?).to eq(true)
      end

      expect(Banker.new(**unsafe_example).safe?).to eq(false)
    end
  end
end
