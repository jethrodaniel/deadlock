# frozen_string_literal: true

require 'parser'

require_relative '../spec/fixtures/sys_config.rb'

describe Parser do
  let(:parser) { Parser.new 'spec/fixtures/sys_config.txt' }

  let(:allocation) { SysConfig.allocation }
  let(:max)        { SysConfig.max }
  let(:available)  { SysConfig.available }

  let(:data) do
    { allocation: allocation, max: max, available: available }
  end

  describe '.new' do
    it 'correctly parses the allocation matrix' do
      expect(parser.allocation).to eq(allocation)
    end

    it 'correctly parses the max matrix' do
      expect(parser.max).to eq(max)
    end

    it 'correctly parses the available vector' do
      expect(parser.available).to eq(available)
    end
  end

  describe '.data' do
    it 'returns the data' do
      expect(parser.data).to eq(data)
    end
  end
end
