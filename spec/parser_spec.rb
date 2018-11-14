require 'parser'

describe Parser do
  let(:parser) { Parser.new 'spec/fixtures/sys_config.txt' }

  let(:allocation) do
    [
      { pid: 0, available: [0, 1, 0, 1, 2, 3] },
      { pid: 1, available: [2, 0, 0, 1, 2, 3] },
      { pid: 2, available: [3, 0, 2, 1, 2, 3] },
      { pid: 3, available: [2, 1, 1, 1, 2, 3] },
      { pid: 4, available: [0, 0, 2, 1, 2, 3] }
    ]
  end

  let(:max) do
    [
      { pid: 0, maximum: [7, 5, 3, 1, 2, 3] },
      { pid: 1, maximum: [3, 2, 2, 1, 2, 3] },
      { pid: 2, maximum: [9, 0, 2, 1, 2, 3] },
      { pid: 3, maximum: [2, 2, 2, 1, 2, 3] },
      { pid: 4, maximum: [4, 3, 3, 1, 2, 3] }
    ]
  end

  describe '.new' do
    it 'creates a new Parser with input' do
      expect(parser).to_not be_nil
    end
  end

  describe '.parse!' do
    it 'parses the input' do
      expect(parser.allocation).to be_nil
      parser.parse!
      expect(parser.allocation).to eq(allocation)
    end
  end

  describe '.parse_allocation' do
    it 'correctly parses the allocation matrix' do
      parser.parse!
      expect(parser.allocation).to eq(allocation)
    end
  end

  describe '.parse_max' do
    it 'correctly parses the max matrix' do
      parser.parse!
      expect(parser.max).to eq(max)
    end
  end
end
