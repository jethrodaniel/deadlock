require 'parser'
require 'banker'

describe Banker do
  let(:parser) { Parser.new 'spec/fixtures/sys_config.txt' }

  describe '#safe?' do
    it 'checks whether a system is in a safe state' do
      expect(Banker.safe? parser.data).to eq(true)
    end
  end
end
