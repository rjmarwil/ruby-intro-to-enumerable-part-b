def select(items, &block)
  words = []
  items.each do |item|
    if block.call(item)
      words << item
    end
  end
  words
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#select' do
  it 'returns an array of words shorter than the given length' do
    input = ['a', 'big', 'black', 'bear', 'is', 'running']

    expect(select(input) { |word| word.length < 3}).to eq(['a', 'is'])
    expect(select(input) { |word| word.length < 4}).to eq(['a', 'big', 'is'])
  end

  it 'returns an empty array when given an empty array, regardless of the provided block' do
    expect(select([]) { |word| word.length < 3}).to eq([])
  end
end
