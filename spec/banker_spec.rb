require 'parser'
require 'banker'

describe Banker do
  let(:data) { Parser.new('spec/fixtures/sys_config.txt').data }

  describe '#safe?' do
    it 'checks whether a system is in a safe state' do
      expect(Banker.safe?(**data)).to eq(true)
    end
  end
end
