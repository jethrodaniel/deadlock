require 'parser'
require 'banker'

describe Banker do
  let(:examples) do
    [
      Parser.new('spec/fixtures/sys_config.txt').data,
      Parser.new('spec/fixtures/wikipedia_example.txt').data,
      Parser.new('spec/fixtures/youtube_example.txt').data
    ]
  end

  describe '#safe?' do
    it 'checks whether a system is in a safe state' do
      examples.each do |example|
        expect(Banker.safe?(**example)).to eq(true)
      end
    end
  end
end
