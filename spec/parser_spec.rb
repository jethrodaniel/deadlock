require 'parser'

describe Parser do
  let(:parser) { Parser.new 'spec/fixtures/sys_config.txt' }

  let(:allocation) do
    Matrix[ [0, 0, 1, 0, 1, 2, 3],
            [1, 2, 0, 0, 1, 2, 3],
            [2, 3, 0, 2, 1, 2, 3],
            [3, 2, 1, 1, 1, 2, 3],
            [4, 0, 0, 2, 1, 2, 3] ]
  end

  let(:max) do
    Matrix[ [0, 7, 5, 3, 1, 2, 3],
            [1, 3, 2, 2, 1, 2, 3],
            [2, 9, 0, 2, 1, 2, 3],
            [3, 2, 2, 2, 1, 2, 3],
            [4, 4, 3, 3, 1, 2, 3] ]
  end

  let(:available) { [3, 3, 2, 1, 2, 3] }

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
