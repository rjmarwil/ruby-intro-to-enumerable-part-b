def reject(items, &block)
  words = []
  items.each do |item|
    unless block.call(item)
      words << item
    end
  end
  words
end

# ------ code above this line ------

require 'rspec/autorun'

RSpec.describe '#reject' do
  it 'returns an array of words where all the words not meeting the condition of the block are removed' do
    input = ['a', 'big', 'black', 'bear', 'is', 'running']

    expect(reject(input) { |word| word.length > 1 }).to eq(['a'])
    expect(reject(input) { |word| word.length > 3 }).to eq(['a', 'big', 'is'])
  end

  it 'returns an empty array when given an empty array, regardless of the block' do
    expect(reject([]) { |fooey| fooey % 2 == 1 }).to eq([])
  end
end
